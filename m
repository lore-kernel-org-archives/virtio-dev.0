Return-Path: <virtio-dev-return-11634-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79884C77B70
	for <virtio-dev@archiver.kernel.org>; Wed, 15 Mar 2023 15:56:09 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 7A1EA1318C7
	for <virtio-dev@archiver.kernel.org>; Wed, 15 Mar 2023 15:56:08 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 61E5D98641B
	for <virtio-dev@archiver.kernel.org>; Wed, 15 Mar 2023 15:56:08 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 4BCD0986402; Wed, 15 Mar 2023 15:56:08 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 39262986406
	for <virtio-dev@lists.oasis-open.org>; Wed, 15 Mar 2023 15:56:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: bcponFskNkqr76tFI_8Mkw-1
From: Cornelia Huck <cohuck@redhat.com>
To: Igor Skalkin <Igor.Skalkin@opensynergy.com>,
 virtio-dev@lists.oasis-open.org, virtio-comment@lists.oasis-open.org,
 luiz.dentz@gmail.com, mst@redhat.com
Cc: marcel@holtmann.org, johan.hedberg@gmail.com, jasowang@redhat.com, Igor
 Skalkin <Igor.Skalkin@opensynergy.com>
In-Reply-To: <20230310062613.109867-2-Igor.Skalkin@opensynergy.com>
Organization: Red Hat GmbH
References: <20230310062613.109867-1-Igor.Skalkin@opensynergy.com>
 <20230310062613.109867-2-Igor.Skalkin@opensynergy.com>
User-Agent: Notmuch/0.37 (https://notmuchmail.org)
Date: Wed, 15 Mar 2023 16:55:59 +0100
Message-ID: <87edpqt3e8.fsf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Subject: [virtio-dev] Re: [virtio-comment] [PATCH 1/1] RFC: virtio-bt: add virtio BT
 device specification

On Fri, Mar 10 2023, Igor Skalkin <Igor.Skalkin@opensynergy.com> wrote:

> This PR is aimed as review for comments(RFC) purpose.
>
> * Initial draft version.
>
> Signed-off-by: Igor Skalkin <Igor.Skalkin@opensynergy.com>
> ---
>  conformance.tex                        |  12 ++-
>  content.tex                            |   1 +
>  device-types/bt/description.tex        | 112 +++++++++++++++++++++++++
>  device-types/bt/device-conformance.tex |   8 ++
>  device-types/bt/driver-conformance.tex |   8 ++
>  5 files changed, 137 insertions(+), 4 deletions(-)
>  create mode 100644 device-types/bt/description.tex
>  create mode 100644 device-types/bt/device-conformance.tex
>  create mode 100644 device-types/bt/driver-conformance.tex

(...)

> diff --git a/device-types/bt/description.tex b/device-types/bt/description.tex
> new file mode 100644
> index 0000000..3ce265d
> --- /dev/null
> +++ b/device-types/bt/description.tex
> @@ -0,0 +1,112 @@
> +\section{BT Device}\label{sec:Device Types / BT Device}
> +
> +The virtio-bt device provides an HCI (Host Control Interface) over VirtIO
> +link between the guest HCI device and the host HCI backend.
> +Also, the device can inform the guest driver which vendor-specific command
> +set it supports.
> +Host Control Interface is described in Bluetooth Core Specification:
> +\newline\url{https://www.bluetooth.com/specifications/specs/core-specification-5-4/}\\

I guess that document describes what the device/driver MUST implement?
If so, I think it needs to be added to the "Normative References"
section in introduction.tex.

> +
> +\subsection{Device ID}\label{sec:Device Types / BT Device / Device ID}
> +
> +40
> +
> +\subsection{Virtqueues}\label{sec:Device Types / BT Device / Virtqueues}
> +
> +\begin{description}
> +\item[0] transmitq
> +\item[1] receiveq
> +\end{description}
> +
> +\subsection{Feature bits}\label{sec:Device Types / BT Device / Feature bits}
> +
> +\begin{description}
> +\item[VIRTIO_BT_F_VND_HCI (0)]  Indicates vendor command support.
> +\item[VIRTIO_BT_F_MSFT_EXT (1)] Indicates MSFT vendor support.
> +\item[VIRTIO_BT_F_AOSP_EXT (2)] Indicates AOSP vendor support.
> +\item[VIRTIO_BT_F_CONFIG_V2 (3)] The device uses the second version of the
> +configuration space structure.
> +\end{description}
> +
> +\devicenormative{\subsubsection}{Feature bits}{Device Types / BT Device / Feature bits}
> +
> +The device MUST require the driver to accept the VIRTIO_BT_F_CONFIG_V2 feature
> +bit, i.e. not set FEATURES_OK without it, and use the second version
> +(struct virtio_bt_config_v2) of the configuration layout, because the
> +first one (struct virtio_bt_config) is unaligned, which violates the
> +specification.

Did we have a device or driver that didn't use v2? I'm not sure we want
to add a feature for that, other than for backwards compatibility.

> +
> +The device should offer VIRTIO_BT_F_MSFT_EXT or VIRTIO_BT_F_AOSP_EXT feature bit
> +if it supports correspondingly MSFT or AOSP extension command sets. In case of
> +VIRTIO_BT_F_MSFT_EXT, device should also set configuration \field{msft_opcode}.
> +
> +The device should offer VIRTIO_BT_F_VND_HCI feature bit and set \field{vendor}
> +to the VIRTIO_BT_CONFIG_VENDOR_ZEPHYR, VIRTIO_BT_CONFIG_VENDOR_INTEL or
> +VIRTIO_BT_CONFIG_VENDOR_REALTEK, if it supports corresponding vendor extensions.

Where are those extension command sets and vendor extensions
described - in the Core Specifications linked above?

> +
> +\drivernormative{\subsubsection}{Feature bits}{Device Types / BT Device / Feature bits}
> +
> +The driver MUST accept VIRTIO_BT_F_CONFIG_V2 feature bit if offered by the device.
> +
> +The driver SHOULD accept any of the  VIRTIO_BT_F_VND_HCI, VIRTIO_BT_F_MSFT_EXT
> +or VIRTIO_BT_F_AOSP_EXT feature bits if offered by the device.
> +
> +\subsection{Device configuration layout}\label{sec:Device Types / BT Device / Device configuration layout}
> +
> +
> +The first version:
> +\begin{lstlisting}
> +struct virtio_bt_config {
> +	u8 type;
> +	le16 vendor;
> +	le16 msft_opcode;
> +} __attribute__((packed));
> +\end{lstlisting}
> +
> +is deprecated, new devices must use the second one:
> +\begin{lstlisting}
> +struct virtio_bt_config_v2 {
> +	u8 type;
> +	u8 alignment;
> +	le16 vendor;
> +	le16 msft_opcode;
> +};
> +\end{lstlisting}
> +
> +\devicenormative{\subsubsection}{Device configuration layout}{Device Types / BT Device / Device configuration layout}
> +The device MUST NOT present a value different than
> +\begin{lstlisting}
> +	VIRTIO_BT_CONFIG_TYPE_PRIMARY = 0,
> +	VIRTIO_BT_CONFIG_TYPE_AMP = 1,
> +\end{lstlisting}
> +in \field{type}.

I think it would be better to move this out of the normative section and
use something like

"
The \field{type} field can have the following values:

\begin{lstlisting}
#define VIRTIO_BT_CONFIG_TYPE_PRIMARY 0
#define VIRTIO_BT_CONFIG_TYPE_AMP     1
\end{lstlisting}
"

I don't think we need to bother with stating explicitly that the device
MUST NOT use any undefined values.

> +
> +The values 1..3 of the \field{vendor} are already reserved for vendor extensions listed below:
> +\begin{lstlisting}
> +	VIRTIO_BT_CONFIG_VENDOR_NONE = 0
> +	VIRTIO_BT_CONFIG_VENDOR_ZEPHYR = 1
> +	VIRTIO_BT_CONFIG_VENDOR_INTEL = 2
> +	VIRTIO_BT_CONFIG_VENDOR_REALTEK = 3
> +\end{lstlisting}

Same here.

I guess the various vendor extensions are mutually exclusive?

> +
> +If value of the \field{vendor} is not VIRTIO_BT_CONFIG_VENDOR_NONE, device MUST
> +offer VIRTIO_BT_F_VND_HCI feature bit.

Maybe

"The device MUST offer the VIRTIO_BT_F_VND_HCI feature bit if it sets
\field{vendor} to any value other than VIRTIO_BT_CONFIG_VENDOR_NONE."

?

> +
> +\drivernormative{\subsubsection}{Driver configuration layout}{Device Types / BT Device / Driver configuration layout}
> +All configuration fields are read-only for the driver.

This isn't a normative statement -- move it to the non-normative
section?

> +
> +\subsection{Device initialization}\label{sec:Device Types / BT Device / Device initialization}
> +
> +The virtqueues are initialized.
> +
> +\subsection{Device operations}\label{sec:Device Types / BT Device / Device operations}
> +
> +The driver SHOULD populate the receive queue with at least one buffer of at

"The driver populates" ?

> +least 258 bytes to contain 1 byte "packet type" and HCI event packet (2 bytes
> +of HCI event packet header and up to 255 bytes payload).
> +Synchronous and asynchronous data packets that are longer than the provided
> +buffer will be fragmented.
> +
> +The driver sends to the transmit queue all (command and data) packets, received
> +from the guest HCI device, and transfers to the guest HCI device all (event and
> +data) HCI packets, received from the receive queue.


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

