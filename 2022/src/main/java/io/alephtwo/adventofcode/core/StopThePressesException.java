package io.alephtwo.adventofcode.core;

/**
 * Denotes an exception for which everything must stop.
 */
public class StopThePressesException extends RuntimeException {
    public StopThePressesException(final Exception e) {
        super(e);
    }

    public StopThePressesException(final String message) {
        super(message);
    }
}
