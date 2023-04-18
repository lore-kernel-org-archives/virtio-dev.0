Return-Path: <virtio-dev-return-12273-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2AF8C77B7D
	for <virtio-dev@archiver.kernel.org>; Tue, 18 Apr 2023 09:10:32 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id CBF83C6230
	for <virtio-dev@archiver.kernel.org>; Tue, 18 Apr 2023 09:10:31 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id A8F67986402
	for <virtio-dev@archiver.kernel.org>; Tue, 18 Apr 2023 09:10:31 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 940A5983EBE; Tue, 18 Apr 2023 09:10:31 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 8133C984043
	for <virtio-dev@lists.oasis-open.org>; Tue, 18 Apr 2023 09:10:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: LhFhOf8ZMgCUMCKYC-wWGA-1
From: Cornelia Huck <cohuck@redhat.com>
To: Haixu Cui <quic_haixcui@quicinc.com>, virtio-dev@lists.oasis-open.org
Cc: quic_ztu@quicinc.com, Haixu Cui <quic_haixcui@quicinc.com>
In-Reply-To: <20230417140353.870-3-quic_haixcui@quicinc.com>
Organization: Red Hat GmbH
References: <20230417140353.870-1-quic_haixcui@quicinc.com>
 <20230417140353.870-3-quic_haixcui@quicinc.com>
User-Agent: Notmuch/0.37 (https://notmuchmail.org)
Date: Tue, 18 Apr 2023 11:10:23 +0200
Message-ID: <87edoh7dz4.fsf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Subject: Re: [virtio-dev][PATCH 2/2] virtio-spi: add the device specification

On Mon, Apr 17 2023, Haixu Cui <quic_haixcui@quicinc.com> wrote:

Meta comment: I think you want to send to virtio-comment (feel free to
keep virtio-dev on cc:).

> virtio-spi is a virtual SPI master and it allows a guset to operate and
> use the physical SPI master controlled by the host.
> ---
>  device-types/spi/description.tex        | 155 ++++++++++++++++++++++++
>  device-types/spi/device-conformance.tex |   7 ++
>  device-types/spi/driver-conformance.tex |   7 ++
>  3 files changed, 169 insertions(+)
>  create mode 100644 device-types/spi/description.tex
>  create mode 100644 device-types/spi/device-conformance.tex
>  create mode 100644 device-types/spi/driver-conformance.tex
>
> diff --git a/device-types/spi/description.tex b/device-types/spi/description.tex
> new file mode 100644
> index 0000000..a68e5f4
> --- /dev/null
> +++ b/device-types/spi/description.tex
> @@ -0,0 +1,155 @@
> +\section{SPI Master Device}\label{sec:Device Types / SPI Master Device}
> +
> +virtio-spi is a virtual SPI(Serial Peripheral Interface) master and it allows a

Nit: missing blank after "SPI"

s/it//

> +guest to operate and use the physical SPI master devices controlled by the host.
> +By attaching the host SPI controlled nodes to the virtual SPI master device, the
> +guest can communicate with them without changing or adding extra drivers for these
> +controlled SPI devices.

Can we rewrite this paragraph without relying on the host/guest
terminology? Does

"allows a driver to operate and use the physical SPI master devices
controlled by the device"

capture the essence of what this is doing?

I don't quite understand the second sentence, maybe someone familiar
with SPI can come up with something.

> +
> +In a typical host and guest architecture with Virtio SPI, Virtio SPI driver
> +is the front-end and exists in the guest kernel, Virtio SPI device acts as

s/guest kernel/guest/ ?

> +the back-end and exists in the host. And VirtQueue is used for communication
> +between the front-end and the back-end.

"A virtqueue is used for communication between the front-end and the
back-end." ?

[I *think* "virtqueue" is the term we've agreed on?]

> +
> +\subsection{Device ID}\label{sec:Device Types / SPI Master Device / Device ID}
> +45
> +
> +\subsection{Virtqueues}\label{sec:Device Types / SPI Master Device / Virtqueues}
> +
> +\begin{description}
> +\item[0] requestq
> +\end{description}
> +
> +\subsection{Feature bits}\label{sec:Device Types / SPI Master Device / Feature bits}
> +
> +None.
> +
> +\subsection{Device configuration layout}\label{sec:Device Types / SPI Master Device / Device configuration layout}
> +
> +All fields of this configuration are always available and read-only for the Virtio SPI driver.
> +
> +\begin{lstlisting}
> +struct virtio_spi_config {
> +    u32 bus_num;
> +    u32 chip_select_max_number;
> +};
> +\end{lstlisting}
> +
> +\begin{description}
> +\item[\field{bus_num}] is the physical spi master assigned to guset, and this is SOC-specific.

Maybe better "the physical SPI master controled by the device"?

> +
> +\item[\field{chip_select_max_number}] is the number of chipselect the physical spi master supported.
> +\end{description}
> +
> +\subsection{Device Initialization}\label{sec:Device Types / SPI Master Device / Device Initialization}
> +
> +\begin{itemize}
> +\item The Virtio SPI driver configures and initializes the virtqueue.
> +
> +\item The Virtio SPI driver allocates and registers the virtual SPI master.

What does this mean? Shouldn't we rather only require the driver to set
up the virtqueue and leave details on how to operate beyond the device
<-> driver interface to the implementation?

> +\end{itemize}
> +
> +\subsection{Device Operation}\label{sec:Device Types / SPI Master Device / Device Operation}
> +
> +\subsubsection{Device Operation: Request Queue}\label{sec:Device Types / SPI Master Device / Device Operation: Request Queue}
> +
> +The Virtio SPI driver queues requests to the virtqueue, and they are used by the
> +Virtio SPI device. Each request represents one SPI transfer and it is of the form:
> +
> +\begin{lstlisting}
> +struct virtio_spi_transfer_head {
> +    u32 mode;
> +    u32 freq;
> +    u32 word_delay;
> +    u8 slave_id;
> +    u8 bits_per_word;
> +    u8 cs_change;
> +    u8 reserved;
> +};
> +\end{lstlisting}

[Side note: it seems the master/slave terminology is baked into SPI and
I assume we cannot avoid it?]

> +
> +\begin{lstlisting}
> +struct virtio_spi_transfer_end {
> +    u8 status;
> +};
> +\end{lstlisting}
> +
> +\begin{lstlisting}
> +struct virtio_spi_req {
> +    struct virtio_spi_transfer_head head;
> +    u8 *rx_buf;
> +    u8 *tx_buf;
> +    struct virtio_spi_transfer_end end;
> +};
> +\end{lstlisting}
> +
> +The \field{mode} defines the SPI transfer mode.
> +
> +The \field{freq} defines the SPI transfer speed in Hz.
> +
> +The \field{word_delay} defines how long to wait between words within one SPI transfer,
> +in ns unit.
> +
> +The \field{slave_id} defines the chipselect index the SPI transfer used.
> +
> +The \field{bits_per_word} defines the number of bits in each SPI transfer word.
> +
> +The \field{cs_change} defines whether to deselect device before starting the next SPI transfer.
> +
> +The \field{rx_buf} is the receive buffer, used to hold the data received from the external device.
> +
> +The \field{tx_buf} is the transmit buffer, used to hold the data sent to the external device.
> +
> +The final \field{status} byte of the request is written by the Virtio SPI device: either
> +VIRTIO_SPI_MSG_OK for success or VIRTIO_SPI_MSG_ERR for error.
> +
> +\begin{lstlisting}
> +#define VIRTIO_SPI_MSG_OK     0
> +#define VIRTIO_SPI_MSG_ERR    1
> +\end{lstlisting}
> +
> +\subsubsection{Device Operation: Operation Status}\label{sec:Device Types / SPI Master Device / Device Operation: Operation Status}
> +
> +Members in \field{struct virtio_spi_transfer_head} are determined by the Virtio SPI driver, while \field{status}
> +in \field{struct virtio_spi_transfer_end} is determined by the processing of the Virtio SPI device.
> +
> +Virtio SPI supports three transfer types: 1) half-duplex read, 2) half-duplex write, 3) full-duplex read and write.
> +For half-duplex read transfer, \field{rx_buf} is filled by the Virtio SPI device and consumed by the Virtio SPI driver.
> +For half-duplex write transfer, \field{tx_buf} is filled by the Virtio SPI driver and consumed by the Virtio SPI device.
> +And for full-duplex read and write transfer, both \field{tx_buf} and \field{rx_buf} are used.
> +
> +\drivernormative{\subsubsection}{Device Operation}{Device Types / SPI Master Device / Device Operation}
> +
> +The Virtio SPI driver MUST send messages on the requestq virtqueue.
> +
> +The \field{struct spi_transfer_head} MUST be filled by the Virtio SPI driver
> +and MUST be readable for the Virtio SPI device.
> +
> +The \field{struct spi_transfer_end} MUST be filled by the Virtio SPI device
> +and MUST be writable for the Virtio SPI device.
> +
> +For half-duplex read, the Virtio SPI driver MUST send \field{struct spi_transfer_head},
> +\field{rx_buf} and \field{struct spi_transfer_end} to the SPI Virtio Device in order.
> +
> +For half-duplex write, the Virtio SPI driver MUST send \field{struct spi_transfer_head},
> +\field{tx_buf} and \field{struct spi_transfer_end} to the SPI Virtio Device in order.
> +
> +For full-duplex read and write, the Virtio SPI driver MUST send \field{struct spi_transfer_head},
> +\field{rx_buf}, \field{tx_buf} and \field{struct spi_transfer_end} to the SPI Virtio Device in order.
> +
> +For half-duplex write or full-duplex read and write, the Virtio SPI driver MUST not use
> +\field{rx_buf} if the final \field{status} returned from the Virtio SPI device is VIRTIO_SPI_MSG_ERR.
> +
> +\devicenormative{\subsubsection}{Device Operation}{Device Types / SPI Master Device / Device Operation}
> +
> +The Virtio SPI device MUST set all the fields of the \field{struct virtio_spi_config} on
> +receiving a configuration request from the Virtio SPI driver.
> +
> +The Virtio SPI device MUST set the \field{struct spi_transfer_end} before sending it
> +back to the Virtio SPI driver.
> +
> +The Virtio SPI device MUST be able to identify the transfer type according to the
> +received VirtQueue descriptors.
> +
> +The Virtio SPI device MUST NOT change the value of the send buffer if transfer type
> +is half-duplex write or full-duplex read and write.

I'm not familiar with how SPI works in general and would appreciate if
someone else could chime in here.


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

