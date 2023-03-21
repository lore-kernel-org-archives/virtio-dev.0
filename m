Return-Path: <virtio-dev-return-11699-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D9F5C6FD20
	for <virtio-dev@archiver.kernel.org>; Tue, 21 Mar 2023 23:24:50 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 7B5212A827
	for <virtio-dev@archiver.kernel.org>; Tue, 21 Mar 2023 23:24:49 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 5F262986452
	for <virtio-dev@archiver.kernel.org>; Tue, 21 Mar 2023 23:24:49 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 46DBA98631B; Tue, 21 Mar 2023 23:24:49 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 3664A98643D
	for <virtio-dev@lists.oasis-open.org>; Tue, 21 Mar 2023 23:24:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679441086;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1oI23eJUaLPl73s+aexPq0J8E4r6l36cl4I73AOIZ5Q=;
        b=ZwNp6gGvpLi31kZb1TeFZn4a9HhNaLYtmoAtCh63BdDEHsJ7StQinCVEMsrJ8AaIXi
         xKrPe7Wp6NllcRnW3hATSTbS4sDKBFza3znesFiJDLmA+HuedJIjzgCcCM+pF2h2y5mc
         YiapIn5yfHv0+8ASIHlGID0LrMSsRxAwlmbfQue635Fly+O2/cApLVWTrssYyju5pPYA
         pZ3LJr1gBJmVbX2P/xPF1ONTrxvk1OxmLBpmS1XOF4KKWgVtQZbX8XDFFmmY+bVVACRN
         PszfmwWaxN+GSSfRSk50/WNFKTSm4ADa9OYeQZ4mcOQrBQfyEVmS0+j99BRsZlFZvHJK
         6jLg==
X-Gm-Message-State: AO0yUKWLk23w1WRu8gQs2+iZtAzG34ZXoG45Mj0zBhAJEherT8smIhrK
	oWNw9fiWY54fVY6SIW0prAdjJxftSI3AnCx6qoZzLg==
X-Google-Smtp-Source: AK7set+IugtFKiktZeY3ZNXOpTAJ1ocNR9HbellJ+sIwluGyCNdItp3/GB5yxgGNPNeTuAz4qRzX5y6xxjBNh3d1vMk=
X-Received: by 2002:a1f:a34e:0:b0:401:4daf:d581 with SMTP id
 m75-20020a1fa34e000000b004014dafd581mr2520146vke.0.1679441085907; Tue, 21 Mar
 2023 16:24:45 -0700 (PDT)
MIME-Version: 1.0
References: <20230310062613.109867-1-Igor.Skalkin@opensynergy.com> <20230310062613.109867-2-Igor.Skalkin@opensynergy.com>
In-Reply-To: <20230310062613.109867-2-Igor.Skalkin@opensynergy.com>
From: Enrico Granata <egranata@google.com>
Date: Tue, 21 Mar 2023 17:24:34 -0600
Message-ID: <CAPR809u5AehjXzjn4QcsVUybL=pW9mWGDJHXfcXRZCXvTcEiLw@mail.gmail.com>
To: Igor Skalkin <Igor.Skalkin@opensynergy.com>
Cc: virtio-dev@lists.oasis-open.org, virtio-comment@lists.oasis-open.org, 
	luiz.dentz@gmail.com, mst@redhat.com, marcel@holtmann.org, 
	johan.hedberg@gmail.com, jasowang@redhat.com, 
	Hao Chen <chenhaosjtuacm@google.com>, Sal Savage <salsavage@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [virtio-dev] [PATCH 1/1] RFC: virtio-bt: add virtio BT device specification

On Thu, Mar 9, 2023 at 11:27=E2=80=AFPM Igor Skalkin
<Igor.Skalkin@opensynergy.com> wrote:
>
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
>
> diff --git a/conformance.tex b/conformance.tex
> index 01ccd69..a69eb47 100644
> --- a/conformance.tex
> +++ b/conformance.tex
> @@ -32,8 +32,9 @@ \section{Conformance Targets}\label{sec:Conformance / C=
onformance Targets}
>  \ref{sec:Conformance / Driver Conformance / Memory Driver Conformance},
>  \ref{sec:Conformance / Driver Conformance / I2C Adapter Driver Conforman=
ce},
>  \ref{sec:Conformance / Driver Conformance / SCMI Driver Conformance},
> -\ref{sec:Conformance / Driver Conformance / GPIO Driver Conformance} or
> -\ref{sec:Conformance / Driver Conformance / PMEM Driver Conformance}.
> +\ref{sec:Conformance / Driver Conformance / GPIO Driver Conformance},
> +\ref{sec:Conformance / Driver Conformance / PMEM Driver Conformance} or
> +\ref{sec:Conformance / Driver Conformance / BT Driver Conformance}
>
>      \item Clause \ref{sec:Conformance / Legacy Interface: Transitional D=
evice and Transitional Driver Conformance}.
>    \end{itemize}
> @@ -59,8 +60,9 @@ \section{Conformance Targets}\label{sec:Conformance / C=
onformance Targets}
>  \ref{sec:Conformance / Device Conformance / Memory Device Conformance},
>  \ref{sec:Conformance / Device Conformance / I2C Adapter Device Conforman=
ce},
>  \ref{sec:Conformance / Device Conformance / SCMI Device Conformance},
> -\ref{sec:Conformance / Device Conformance / GPIO Device Conformance} or
> -\ref{sec:Conformance / Device Conformance / PMEM Device Conformance}.
> +\ref{sec:Conformance / Device Conformance / GPIO Device Conformance},
> +\ref{sec:Conformance / Device Conformance / PMEM Device Conformance} or
> +\ref{sec:Conformance / Device Conformance / BT Device Conformance}
>
>      \item Clause \ref{sec:Conformance / Legacy Interface: Transitional D=
evice and Transitional Driver Conformance}.
>    \end{itemize}
> @@ -152,6 +154,7 @@ \section{Conformance Targets}\label{sec:Conformance /=
 Conformance Targets}
>  \input{device-types/scmi/driver-conformance.tex}
>  \input{device-types/gpio/driver-conformance.tex}
>  \input{device-types/pmem/driver-conformance.tex}
> +\input{device-types/bt/driver-conformance.tex}
>
>  \conformance{\section}{Device Conformance}\label{sec:Conformance / Devic=
e Conformance}
>
> @@ -238,6 +241,7 @@ \section{Conformance Targets}\label{sec:Conformance /=
 Conformance Targets}
>  \input{device-types/scmi/device-conformance.tex}
>  \input{device-types/gpio/device-conformance.tex}
>  \input{device-types/pmem/device-conformance.tex}
> +\input{device-types/bt/device-conformance.tex}
>
>  \conformance{\section}{Legacy Interface: Transitional Device and Transit=
ional Driver Conformance}\label{sec:Conformance / Legacy Interface: Transit=
ional Device and Transitional Driver Conformance}
>  A conformant implementation MUST be either transitional or
> diff --git a/content.tex b/content.tex
> index 0c7cdf8..3723ec8 100644
> --- a/content.tex
> +++ b/content.tex
> @@ -3022,6 +3022,7 @@ \chapter{Device Types}\label{sec:Device Types}
>  \input{device-types/scmi/description.tex}
>  \input{device-types/gpio/description.tex}
>  \input{device-types/pmem/description.tex}
> +\input{device-types/bt/description.tex}
>
>  \chapter{Reserved Feature Bits}\label{sec:Reserved Feature Bits}
>
> diff --git a/device-types/bt/description.tex b/device-types/bt/descriptio=
n.tex
> new file mode 100644
> index 0000000..3ce265d
> --- /dev/null
> +++ b/device-types/bt/description.tex
> @@ -0,0 +1,112 @@
> +\section{BT Device}\label{sec:Device Types / BT Device}
> +
> +The virtio-bt device provides an HCI (Host Control Interface) over VirtI=
O
> +link between the guest HCI device and the host HCI backend.
> +Also, the device can inform the guest driver which vendor-specific comma=
nd
> +set it supports.
> +Host Control Interface is described in Bluetooth Core Specification:
> +\newline\url{https://www.bluetooth.com/specifications/specs/core-specifi=
cation-5-4/}\\

Are you giving any thought to out of band communication (e.g. A2DP and HFP)=
?

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
> +\subsection{Feature bits}\label{sec:Device Types / BT Device / Feature b=
its}
> +
> +\begin{description}
> +\item[VIRTIO_BT_F_VND_HCI (0)]  Indicates vendor command support.
> +\item[VIRTIO_BT_F_MSFT_EXT (1)] Indicates MSFT vendor support.
> +\item[VIRTIO_BT_F_AOSP_EXT (2)] Indicates AOSP vendor support.
> +\item[VIRTIO_BT_F_CONFIG_V2 (3)] The device uses the second version of t=
he
> +configuration space structure.
> +\end{description}
> +

How are these different from the vendor fields discussed elsewhere in the s=
pec?
Is it the idea that any vendor could support AOSP or MSFT specific
command sets, and so you need two separate flags?

If so, maybe calling them "guest OS support" instead of "vendor" might
be a better choice to avoid confusion
Also, we should probably document somewhere what commands those
extensions entail

> +\devicenormative{\subsubsection}{Feature bits}{Device Types / BT Device =
/ Feature bits}
> +
> +The device MUST require the driver to accept the VIRTIO_BT_F_CONFIG_V2 f=
eature
> +bit, i.e. not set FEATURES_OK without it, and use the second version
> +(struct virtio_bt_config_v2) of the configuration layout, because the
> +first one (struct virtio_bt_config) is unaligned, which violates the
> +specification.
> +
> +The device should offer VIRTIO_BT_F_MSFT_EXT or VIRTIO_BT_F_AOSP_EXT fea=
ture bit
> +if it supports correspondingly MSFT or AOSP extension command sets. In c=
ase of
> +VIRTIO_BT_F_MSFT_EXT, device should also set configuration \field{msft_o=
pcode}.
> +
> +The device should offer VIRTIO_BT_F_VND_HCI feature bit and set \field{v=
endor}
> +to the VIRTIO_BT_CONFIG_VENDOR_ZEPHYR, VIRTIO_BT_CONFIG_VENDOR_INTEL or
> +VIRTIO_BT_CONFIG_VENDOR_REALTEK, if it supports corresponding vendor ext=
ensions.
> +
> +\drivernormative{\subsubsection}{Feature bits}{Device Types / BT Device =
/ Feature bits}
> +
> +The driver MUST accept VIRTIO_BT_F_CONFIG_V2 feature bit if offered by t=
he device.
> +
> +The driver SHOULD accept any of the  VIRTIO_BT_F_VND_HCI, VIRTIO_BT_F_MS=
FT_EXT
> +or VIRTIO_BT_F_AOSP_EXT feature bits if offered by the device.
> +
> +\subsection{Device configuration layout}\label{sec:Device Types / BT Dev=
ice / Device configuration layout}
> +
> +
> +The first version:
> +\begin{lstlisting}
> +struct virtio_bt_config {
> +       u8 type;
> +       le16 vendor;
> +       le16 msft_opcode;
> +} __attribute__((packed));
> +\end{lstlisting}
> +
> +is deprecated, new devices must use the second one:
> +\begin{lstlisting}
> +struct virtio_bt_config_v2 {
> +       u8 type;
> +       u8 alignment;
> +       le16 vendor;
> +       le16 msft_opcode;
> +};
> +\end{lstlisting}
> +
> +\devicenormative{\subsubsection}{Device configuration layout}{Device Typ=
es / BT Device / Device configuration layout}
> +The device MUST NOT present a value different than
> +\begin{lstlisting}
> +       VIRTIO_BT_CONFIG_TYPE_PRIMARY =3D 0,
> +       VIRTIO_BT_CONFIG_TYPE_AMP =3D 1,
> +\end{lstlisting}
> +in \field{type}.

What do these values mean?

> +
> +The values 1..3 of the \field{vendor} are already reserved for vendor ex=
tensions listed below:
> +\begin{lstlisting}
> +       VIRTIO_BT_CONFIG_VENDOR_NONE =3D 0
> +       VIRTIO_BT_CONFIG_VENDOR_ZEPHYR =3D 1
> +       VIRTIO_BT_CONFIG_VENDOR_INTEL =3D 2
> +       VIRTIO_BT_CONFIG_VENDOR_REALTEK =3D 3
> +\end{lstlisting}
> +

How would any other vendor add their extensions to this list?
For example, say I start my own Bluetooth adapter company tomorrow,
how do I add VENDOR_ENRICO to the list?

> +If value of the \field{vendor} is not VIRTIO_BT_CONFIG_VENDOR_NONE, devi=
ce MUST
> +offer VIRTIO_BT_F_VND_HCI feature bit.
> +
> +\drivernormative{\subsubsection}{Driver configuration layout}{Device Typ=
es / BT Device / Driver configuration layout}
> +All configuration fields are read-only for the driver.
> +
> +\subsection{Device initialization}\label{sec:Device Types / BT Device / =
Device initialization}
> +
> +The virtqueues are initialized.
> +
> +\subsection{Device operations}\label{sec:Device Types / BT Device / Devi=
ce operations}
> +
> +The driver SHOULD populate the receive queue with at least one buffer of=
 at
> +least 258 bytes to contain 1 byte "packet type" and HCI event packet (2 =
bytes
> +of HCI event packet header and up to 255 bytes payload).
> +Synchronous and asynchronous data packets that are longer than the provi=
ded
> +buffer will be fragmented.
> +
> +The driver sends to the transmit queue all (command and data) packets, r=
eceived
> +from the guest HCI device, and transfers to the guest HCI device all (ev=
ent and
> +data) HCI packets, received from the receive queue.
> diff --git a/device-types/bt/device-conformance.tex b/device-types/bt/dev=
ice-conformance.tex
> new file mode 100644
> index 0000000..7b73f4a
> --- /dev/null
> +++ b/device-types/bt/device-conformance.tex
> @@ -0,0 +1,8 @@
> +\conformance{\subsection}{Bluetooth Device Conformance}\label{sec:Confor=
mance / Device Conformance / Bluetooth Device Conformance}
> +
> +A BT device MUST conform to the following normative statements:
> +
> +\begin{itemize}
> +\item \ref{devicenormative:Device Types / BT Device / Feature bits}
> +\item \ref{devicenormative:Device Types / BT Device / Device configurati=
on layout}
> +\end{itemize}
> diff --git a/device-types/bt/driver-conformance.tex b/device-types/bt/dri=
ver-conformance.tex
> new file mode 100644
> index 0000000..2264a79
> --- /dev/null
> +++ b/device-types/bt/driver-conformance.tex
> @@ -0,0 +1,8 @@
> +\conformance{\subsection}{BT Driver Conformance}\label{sec:Conformance /=
 Driver Conformance / BT Driver Conformance}
> +
> +A BT driver MUST conform to the following normative statements:
> +
> +\begin{itemize}
> +\item \ref{drivernormative:Device Types / BT Device / Feature bits}
> +\item \ref{drivernormative:Device Types / BT Device / Driver configurati=
on layout}
> +\end{itemize}
> --
> 2.37.2
>
>
> ---------------------------------------------------------------------
> To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
> For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org
>

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

