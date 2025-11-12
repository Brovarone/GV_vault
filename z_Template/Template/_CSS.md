da copiare in \.obsidian\snippets

/* ---------------  CALLOUT --------------- */
/* Specifico per embed annidati (dal tuo HTML: .internal-embed e .markdown-embed-content) */
/*info = png*/
.callout[data-callout="png"] .internal-embed,
.callout[data-callout="png"] .markdown-embed-content,
.callout[data-callout="png"] .markdown-preview-view {
    border-left: none !important;
    padding-left: 0 !important;
    margin-left: 0 !important;
}

.callout[data-callout="png"] {
    /* colore di sfondo (RGB + opacità) */
    --callout-color: 2, 122, 255;          /* #502929 */
    --callout-color-opacity: 0.15;

    /* icona da mostrare nel titolo */
    /* %23 è l’equivalente di # in un data‑URI. */
    --callout-icon: url('data:image/svg+xml;utf8,<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="%23027aff" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="lucide lucide-users-round-icon lucide-users-round"><path d="M18 21a8 8 0 0 0-16 0"/><circle cx="10" cy="8" r="5"/><path d="M22 20c0-3.37-2-6.5-4-8a5 5 0 0 0-.45-8.3"/></svg>');
}

/* rimuovi l’icona “vecchia” (se non la vuoi) */
.callout[data-callout="png"] .callout-icon {
    display: none;
}

/* titolo con icona */
.callout[data-callout="png"] .callout-title {
    color: #027aff;               /* colore del testo del titolo */
    position: relative;
    padding-left: 1.8em;          /* spazio per l’icona */
	padding-right: 4em; 		/* spazio a destra per il numero */
}

/* inserisci l’icona prima del titolo */
.callout[data-callout="png"] .callout-title::before {
    content: var(--callout-icon);
    position: absolute;
    left: 0;
    top: 50%;
    transform: translateY(-50%);
    width: 1.2em;
    height: 1.2em;
}

/* Mostra il numero dopo il titolo */
.callout[data-callout="png"] .callout-title::after {
    content: " (" attr(data-rows) ")";
    position: absolute;
    right: 0.5em;
    opacity: 0.7;
    font-weight: normal;
    font-size: 0.9em;
}

/*abstract = organizzazioni*/
.callout[data-callout="organizzazioni"] .internal-embed,
.callout[data-callout="organizzazioni"] .markdown-embed-content,
.callout[data-callout="organizzazioni"] .markdown-preview-view {
    border-left: none !important;
    padding-left: 0 !important;
    margin-left: 0 !important;
}

.callout[data-callout="organizzazioni"] {
    /* colore di sfondo (RGB + opacità) */
    --callout-color: 83, 223, 221;          /* #502929 */
    --callout-color-opacity: 0.15;

    /* icona da mostrare nel titolo */
    /* %23 è l’equivalente di # in un data‑URI. */
    --callout-icon: url('data:image/svg+xml;utf8,<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="%2353dfdd" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="svg-icon lucide-clipboard-list"><rect x="8" y="2" width="8" height="4" rx="1" ry="1"></rect><path d="M16 4h2a2 2 0 0 1 2 2v14a2 2 0 0 1-2 2H6a2 2 0 0 1-2-2V6a2 2 0 0 1 2-2h2"></path><path d="M12 11h4"></path><path d="M12 16h4"></path><path d="M8 11h.01"></path><path d="M8 16h.01"></path></svg>');
}

/* rimuovi l’icona “vecchia” (se non la vuoi) */
.callout[data-callout="organizzazioni"] .callout-icon {
    display: none;
}

/* titolo con icona */
.callout[data-callout="organizzazioni"] .callout-title {
    color: #53dfdd;               /* colore del testo del titolo */
    position: relative;
    padding-left: 1.8em;          /* spazio per l’icona */
}

/* inserisci l’icona prima del titolo */
.callout[data-callout="organizzazioni"] .callout-title::before {
    content: var(--callout-icon);
    position: absolute;
    left: 0;
    top: 50%;
    transform: translateY(-50%);
    width: 1.2em;
    height: 1.2em;
}

/*example = sublocation*/
.callout[data-callout="sublocation"] .internal-embed,
.callout[data-callout="sublocation"] .markdown-embed-content,
.callout[data-callout="sublocation"] .markdown-preview-view {
    border-left: none !important;
    padding-left: 0 !important;
    margin-left: 0 !important;
}

.callout[data-callout="sublocation"] {
    /* colore di sfondo (RGB + opacità) */
    --callout-color: 168, 130, 255;          /* #502929 */
    --callout-color-opacity: 0.15;

    /* icona da mostrare nel titolo */
    /* %23 è l’equivalente di # in un data‑URI. */
    --callout-icon: url('data:image/svg+xml;utf8,<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="%23a882ff" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="svg-icon lucide-list"><line x1="8" y1="6" x2="21" y2="6"></line><line x1="8" y1="12" x2="21" y2="12"></line><line x1="8" y1="18" x2="21" y2="18"></line><line x1="3" y1="6" x2="3.01" y2="6"></line><line x1="3" y1="12" x2="3.01" y2="12"></line><line x1="3" y1="18" x2="3.01" y2="18"></line></svg>');
}

/* rimuovi l’icona “vecchia” (se non la vuoi) */
.callout[data-callout="sublocation"] .callout-icon {
    display: none;
}

/* titolo con icona */
.callout[data-callout="sublocation"] .callout-title {
    color: #a882ff;               /* colore del testo del titolo */
    position: relative;
    padding-left: 1.8em;          /* spazio per l’icona */
}

/* inserisci l’icona prima del titolo */
.callout[data-callout="sublocation"] .callout-title::before {
    content: var(--callout-icon);
    position: absolute;
    left: 0;
    top: 50%;
    transform: translateY(-50%);
    width: 1.2em;
    height: 1.2em;
}

/*apparein*/
.callout[data-callout="apparein"] .internal-embed,
.callout[data-callout="apparein"] .markdown-embed-content,
.callout[data-callout="apparein"] .markdown-preview-view {
    border-left: none !important;
    padding-left: 0 !important;
    margin-left: 0 !important;
}

.callout[data-callout="apparein"] {
    /* colore di sfondo (RGB + opacità) */
    --callout-color: 170, 60, 85;         
    --callout-color-opacity: 0.15;

    /* icona da mostrare nel titolo */
    /* %23 è l’equivalente di # in un data‑URI. */
    --callout-icon: url('data:image/svg+xml;utf8,<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="%23f2bcc9" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="lucide lucide-earth-icon lucide-earth"><path d="M21.54 15H17a2 2 0 0 0-2 2v4.54"/><path d="M7 3.34V5a3 3 0 0 0 3 3a2 2 0 0 1 2 2c0 1.1.9 2 2 2a2 2 0 0 0 2-2c0-1.1.9-2 2-2h3.17"/><path d="M11 21.95V18a2 2 0 0 0-2-2a2 2 0 0 1-2-2v-1a2 2 0 0 0-2-2H2.05"/><circle cx="12" cy="12" r="10"/></svg>');
}

/* rimuovi l’icona “vecchia” (se non la vuoi) */
.callout[data-callout="apparein"] .callout-icon {
    display: none;
}

/* titolo con icona */
.callout[data-callout="apparein"] .callout-title {
    color: #f2bcc9;               /* colore del testo del titolo */
    position: relative;
    padding-left: 1.8em;          /* spazio per l’icona */
}

/* inserisci l’icona prima del titolo */
.callout[data-callout="apparein"] .callout-title::before {
    content: var(--callout-icon);
    position: absolute;
    left: 0;
    top: 50%;
    transform: translateY(-50%);
    width: 1.2em;
    height: 1.2em;
}