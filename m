Return-Path: <virtio-dev-return-14247-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0D57C3DA79
	for <virtio-dev@archiver.kernel.org>; Mon, 15 Jan 2024 15:09:33 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 9E3432B150
	for <virtio-dev@archiver.kernel.org>; Mon, 15 Jan 2024 15:09:32 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 388CC986511
	for <virtio-dev@archiver.kernel.org>; Mon, 15 Jan 2024 15:09:32 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 1E8D2986396; Mon, 15 Jan 2024 15:09:32 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 0E1EB9863A8
	for <virtio-dev@lists.oasis-open.org>; Mon, 15 Jan 2024 15:09:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: NmA3R31kNpqwkBIaBPyrGQ-1
From: Cornelia Huck <cohuck@redhat.com>
To: Igor Skalkin <Igor.Skalkin@opensynergy.com>,
 virtio-dev@lists.oasis-open.org, virtio-comment@lists.oasis-open.org,
 luiz.dentz@gmail.com, mst@redhat.com
Cc: marcel@holtmann.org, johan.hedberg@gmail.com, jasowang@redhat.com,
 boris.le.labousse@opensynergy.com, Igor Skalkin
 <Igor.Skalkin@opensynergy.com>
In-Reply-To: <20231207163721.26737-2-Igor.Skalkin@opensynergy.com>
Organization: "Red Hat GmbH, Sitz: Werner-von-Siemens-Ring 12, D-85630
 Grasbrunn, Handelsregister: Amtsgericht =?utf-8?Q?M=C3=BCnchen=2C?= HRB
 153243,
 =?utf-8?Q?Gesch=C3=A4ftsf=C3=BChrer=3A?= Ryan Barnhart, Charles Cachera,
 Michael O'Neill, Amy
 Ross"
References: <20231207163721.26737-1-Igor.Skalkin@opensynergy.com>
 <20231207163721.26737-2-Igor.Skalkin@opensynergy.com>
User-Agent: Notmuch/0.37 (https://notmuchmail.org)
Date: Mon, 15 Jan 2024 16:09:27 +0100
Message-ID: <87zfx6my54.fsf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Subject: [virtio-dev] Re: [virtio-comment] [PATCH v2 1/1] RFC: virtio-bt: add virtio BT
 device specification

On Thu, Dec 07 2023, Igor Skalkin <Igor.Skalkin@opensynergy.com> wrote:

> diff --git a/device-types/bt/description.tex b/device-types/bt/description.tex
> new file mode 100644
> index 0000000..98311f4
> --- /dev/null
> +++ b/device-types/bt/description.tex
> @@ -0,0 +1,158 @@
> +\section{BT Device}\label{sec:Device Types / BT Device}
> +
> +The virtio-bt device provides an HCI (Host Control Interface) over VirtIO
> +link between the guest HCI device and the host HCI backend.
> +Also, the device can inform the guest driver which operational system / vendor
> + specific HCI extensions it supports.

Is there any good way to describe this without using guest/host
terminology while using the typical guest/host setup as an example
instead?

> +Host Control Interface is described in Bluetooth Core Specification (see
> +\hyperref[intro:bluetooth-core]{Bluetooth Core Specification}).
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
> +\item[VIRTIO_BT_F_VND_HCI (0)]  The device supports vendor-specific HCI
> +extensions.
> +\item[VIRTIO_BT_F_MSFT_EXT (1)] The device supports Microsoft HCI Extensions.
> +\item[VIRTIO_BT_F_AOSP_EXT (2)] The device supports Android HCI Extensions.
> +\item[VIRTIO_BT_F_CONFIG_V2 (3)] The device uses the second version of the
> +configuration space structure.
> +\end{description}
> +
> +\devicenormative{\subsubsection}{Feature bits}{Device Types / BT Device / Feature bits}
> +
> +The device MAY require the driver to accept the \field{VIRTIO_BT_F_CONFIG_V2}
> +feature bit and use the second version of the configuration layout, because the
> +first one is unaligned, which violates the specification.

ISTR that it was "violates the requirements for configuration space
accesses for some transports"? That might be a bit clearer.

And if that's the case, can we maybe require that the device MUST
require the driver to accept the feature bit if the transport the device
uses cannot deal with v1?

> +
> +The device should offer \field{VIRTIO_BT_F_MSFT_EXT} or

s/should offer/SHOULD offer the/

> +\field{VIRTIO_BT_F_AOSP_EXT} feature bit if it supports correspondingly MSFT or
> +AOSP extension command sets (see \hyperref[intro:bluetooth-aosp]{Bluetooth AOSP
> +HCI Extensions}, \hyperref[intro:bluetooth-msft]{Bluetooth MSFT HCI Extensions}
> +). In case of \field{VIRTIO_BT_F_MSFT_EXT}, device should also set configuration

"the device SHOULD also set the configuration field"

> +field \field{msft_opcode}.
> +
> +The device should offer \field{VIRTIO_BT_F_VND_HCI} feature bit and set

s/should offer/SHOULD offer the/
s/set/set the/

> +configuration field \field{vendor}, if it supports corresponding vendor

s/corresponding/the corresponding/

> +extensions. Also, in case of second configuration version, fields

s/in case of second configuration version/if VIRTIO_BT_F_CONFIG_V2 is negotiated/

> +\field{set_bdaddr_opcode} and \field{quirks} can be set according to this

MAY be set? Or SHOULD be set?

> +\field{vendor}.
> +
> +\drivernormative{\subsubsection}{Feature bits}{Device Types / BT Device / Feature bits}
> +
> +The driver MUST accept \field{VIRTIO_BT_F_CONFIG_V2} feature bit if offered by
> +the device.
> +
> +The driver SHOULD accept any of the  \field{VIRTIO_BT_F_VND_HCI},
> +\field{VIRTIO_BT_F_MSFT_EXT} or \field{VIRTIO_BT_F_AOSP_EXT} feature bits if
> +offered by the device.
> +
> +\subsection{Device configuration layout}\label{sec:Device Types / BT Device / Device configuration layout}
> +BT device supports two versions of the configuration structure layout.
> +\subsubsection{Device configuration layout: Version 1}\label{sec:Device Types / BT Device / Device configuration layout / Verion 1}
> +
> +All fields of this configuration are always available and read-only for the
> +driver.
> +\begin{lstlisting}
> +struct virtio_bt_config {
> +    u8 type;
> +    le16 vendor;
> +    le16 msft_opcode;
> +} __attribute__((packed));
> +\end{lstlisting}
> +
> +\begin{description}
> +
> +\item[\field{type}] indicates the type of the device, is it "Primary BR/EDR
> +controller" or "Alternate MAC/PHYs (AMP) secondary controller" and can have the
> +following values:
> +\begin{lstlisting}
> +#define VIRTIO_BT_CONFIG_TYPE_PRIMARY 0
> +#define VIRTIO_BT_CONFIG_TYPE_AMP     1
> +\end{lstlisting}
> +
> +\item[\field{vendor}]
> +Indicates the vendor of the BT device and can have the following mutually
> +exclusive values:
> +\begin{lstlisting}
> +#define VIRTIO_BT_CONFIG_VENDOR_NONE     0
> +#define VIRTIO_BT_CONFIG_VENDOR_ZEPHYR   1
> +#define VIRTIO_BT_CONFIG_VENDOR_INTEL    2
> +#define VIRTIO_BT_CONFIG_VENDOR_REALTEK  3
> +\end{lstlisting}
> +The device MUST offer the \field{VIRTIO_BT_F_VND_HCI} feature bit if it sets
> +\field{vendor} to any value other than \field{VIRTIO_BT_CONFIG_VENDOR_NONE}.

Any MUST statement has to go into a normative section.


> +In the current Linux implementation of virtio-bt, these values are simply
> +hard-coded and point to the hard-coded (\field{manufacturer},
> +\field{set_bdaddr_opcode}, \field{quirks}) parameters, there
> +\field{manufacturer} is a "Company Identifier" from the
> +\hyperref[intro:bluetooth-numbers]{Bluetooth Assigned Numbers}, Chapter 7
> +(Company Identifiers).
> +This approach is not extensible and has been replaced in the second version of
> +the configuration.

All of the above should probably go into a "Note" statement, as it
basically explains why things are as they are?

> +\item[\field{msft_opcode}]
> +This field is used by the driver if device offers \field{VIRTIO_BT_F_MSFT_EXT}

s/device/the device/

> +feature bit.
> +\end{description}
> +
> +\subsubsection{Device configuration layout: Version 2}\label{sec:Device Types / BT Device / Device configuration layout / Version 2}
> +All fields of this configuration are always available and read-only for the
> +driver.
> +\begin{lstlisting}
> +struct virtio_bt_config_v2 {
> +    le16 vendor;
> +    le16 set_bdaddr_opcode;
> +    le32 quirks;
> +    le16 msft_opcode;
> +};
> +\end{lstlisting}
> +
> +\begin{description}
> +
> +\item[\field{vendor}] - Manufacturer identifier, for the possible values see
> +\hyperref[intro:bluetooth-numbers]{Bluetooth Assigned Numbers}, Chapter 7
> +(Company Identifiers).
> +The device MUST offer the VIRTIO_BT_F_VND_HCI feature bit if it sets
> +\field{vendor} to any value other than VIRTIO_BT_CONFIG_VENDOR_NONE.

Again, MUST statements have to go into a normative section.

> +According to the Linux guest driver implementation, devices from different
> +vendors can have different opcodes for the \field{set_bdaddr} (Bluetooth Device
> +Address) command, and the different \field{quirks} bits (list and short
> +description of these \field{quirks} you can find in
> +\hyperref[intro:bluetooth-quirks]{Bluetooth HCI device quirks}.

Some of this should be extracted into some kind of "Note" as well. IIUC,
the aim here is to specify what the Linux driver expects, so that people
can write devices that driver works with out of the box, and that
informs the specification here?

> +So, next two fields allow us to set these parameters.
> +
> +\item[\field{set_bdaddr_opcode}] - opcode for the set_bdaddr (Bluetooth Device
> +Address) command.
> +\item[\field{quirks}] - Quirks bits supported by the device.
> +\hyperref[intro:bluetooth-quirks]{Bluetooth HCI device quirks}
> +
> +\item[\field{msft_opcode}]
> +This fields is used by the driver if device offers \field{VIRTIO_BT_F_MSFT_EXT}

s/fields/field/
s/device/the device/

> +feature bit.
> +\end{description}


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

