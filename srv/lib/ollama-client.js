import analysisSchema from "./analysis-schema.js";

/*
 * Ollama URL
 *
 * Local development:
 * http://localhost:11434
 *
 * Docker later:
 * http://ollama:11434
 */
const OLLAMA_BASE_URL = process.env.OLLAMA_BASE_URL || "http://localhost:11434";

/*
 * Default model.
 *
 * You can override this using:
 *
 * OLLAMA_MODEL=qwen3:8b
 */
const OLLAMA_MODEL = process.env.OLLAMA_MODEL || "qwen3:8b";

/*
 * Request timeout.
 */
const OLLAMA_TIMEOUT_MS = Number(process.env.OLLAMA_TIMEOUT_MS || 120000);

export async function analyzeWithOllama(messages) {
  const controller = new AbortController();

  const timeout = setTimeout(() => controller.abort(), OLLAMA_TIMEOUT_MS);

  try {
    console.log(`[Ollama] Sending request to ${OLLAMA_BASE_URL}`);

    console.log(`[Ollama] Model: ${OLLAMA_MODEL}`);

    const response = await fetch(`${OLLAMA_BASE_URL}/api/chat`, {
      method: "POST",

      headers: {
        "Content-Type": "application/json",
      },

      signal: controller.signal,

      body: JSON.stringify({
        model: OLLAMA_MODEL,

        messages,

        stream: false,

        format: analysisSchema,

        think: false,

        options: {
          temperature: 0.1,
          num_predict: 1000,
        },
      }),
    });

    /*
     * HTTP level failure
     */
    if (!response.ok) {
      const body = await response.text();

      throw new Error(
        `Ollama returned HTTP ${response.status}: ${body.slice(0, 500)}`,
      );
    }

    /*
     * Parse Ollama response.
     */
    const result = await response.json();

    const content = result?.message?.content;

    if (!content) {
      throw new Error("Ollama response did not contain message.content.");
    }

    /*
     * Ollama sends our structured output as JSON text
     * inside message.content.
     */
    let parsed;

    try {
      parsed = typeof content === "string" ? JSON.parse(content) : content;
    } catch (error) {
      throw new Error(`Ollama returned invalid JSON: ${error.message}`);
    }

    return {
      model: result.model || OLLAMA_MODEL,

      data: parsed,
    };
  } catch (error) {
    /*
     * Give a clearer message when Ollama takes too long.
     */
    if (error.name === "AbortError") {
      throw new Error(
        `Ollama model "${OLLAMA_MODEL}" did not finish within ` +
          `${OLLAMA_TIMEOUT_MS / 1000} seconds. ` +
          `The model may be too large for the available hardware.`,
      );
    }

    /*
     * This is the usual error if Ollama itself isn't running.
     */
    if (error.cause?.code === "ECONNREFUSED") {
      throw new Error(
        `Cannot connect to Ollama at ${OLLAMA_BASE_URL}. Make sure Ollama is running.`,
      );
    }

    throw error;
  } finally {
    clearTimeout(timeout);
  }
}
