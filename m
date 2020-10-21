Return-Path: virtio-comment-return-1461-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
Date: Wed, 21 Oct 2020 08:08:23 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20201021080250-mutt-send-email-mst@kernel.org>
References: <7e62cac21047d1692edea06c1fd917faea53087f.1600742717.git.jie.deng@intel.com>
MIME-Version: 1.0
In-Reply-To: <7e62cac21047d1692edea06c1fd917faea53087f.1600742717.git.jie.deng@intel.com>
Subject: Re: [virtio-comment] [PATCH] virtio-i2c: add the device specification
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
To: Jie Deng <jie.deng@intel.com>
Cc: virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

On Tue, Sep 22, 2020 at 10:49:02AM +0800, Jie Deng wrote:
> virtio-i2c is a virtual I2C adapter device. It provides a way
> to =EF=AC=82exibly communicate with the I2C slave devices from the guest.
>=20
> This patch adds the specification for this device.
>=20
> Signed-off-by: Jie Deng <jie.deng@intel.com>
> ---
>  conformance.tex | 28 ++++++++++++++++---
>  content.tex     |  1 +
>  virtio-i2c.tex  | 85 +++++++++++++++++++++++++++++++++++++++++++++++++++=
++++++
>  3 files changed, 110 insertions(+), 4 deletions(-)
>  create mode 100644 virtio-i2c.tex
>=20
> diff --git a/conformance.tex b/conformance.tex
> index f1f23a8..12bce3a 100644
> --- a/conformance.tex
> +++ b/conformance.tex
> @@ -27,8 +27,10 @@ \section{Conformance Targets}\label{sec:Conformance / =
Conformance Targets}
>  \ref{sec:Conformance / Driver Conformance / Socket Driver Conformance},
>  \ref{sec:Conformance / Driver Conformance / RPMB Driver Conformance},
>  \ref{sec:Conformance / Driver Conformance / IOMMU Driver Conformance},
> -\ref{sec:Conformance / Driver Conformance / Sound Driver Conformance} or
> -\ref{sec:Conformance / Driver Conformance / Memory Driver Conformance}.
> +\ref{sec:Conformance / Driver Conformance / Sound Driver Conformance}
> +\ref{sec:Conformance / Driver Conformance / Memory Driver Conformance} o=
r
> +\ref{sec:Conformance / Driver Conformance / I2C Adapter Driver Conforman=
ce}.
> +
>      \item Clause \ref{sec:Conformance / Legacy Interface: Transitional D=
evice and Transitional Driver Conformance}.
>    \end{itemize}
>  \item[Device] A device MUST conform to four conformance clauses:
> @@ -47,8 +49,10 @@ \section{Conformance Targets}\label{sec:Conformance / =
Conformance Targets}
>  \ref{sec:Conformance / Device Conformance / Socket Device Conformance},=
=20
>  \ref{sec:Conformance / Device Conformance / RPMB Device Conformance},
>  \ref{sec:Conformance / Device Conformance / IOMMU Device Conformance},
> -\ref{sec:Conformance / Device Conformance / Sound Device Conformance} or
> -\ref{sec:Conformance / Device Conformance / Memory Device Conformance}.
> +\ref{sec:Conformance / Device Conformance / Sound Device Conformance}
> +\ref{sec:Conformance / Device Conformance / Memory Device Conformance} o=
r
> +\ref{sec:Conformance / Device Conformance / I2C Adapter Device Conforman=
ce}.
> +
>      \item Clause \ref{sec:Conformance / Legacy Interface: Transitional D=
evice and Transitional Driver Conformance}.
>    \end{itemize}
>  \end{description}
> @@ -261,6 +265,14 @@ \section{Conformance Targets}\label{sec:Conformance =
/ Conformance Targets}
>  \item \ref{drivernormative:Device Types / Memory Device / Device Operati=
on / STATE request}
>  \end{itemize}
> =20
> +\conformance{\subsection}{I2C Adapter Driver Conformance}\label{sec:Conf=
ormance / Driver Conformance / I2C Adapter Driver Conformance}
> +
> +An I2C Adapter driver MUST conform to the following normative statements=
:
> +
> +\begin{itemize}
> +\item \ref{drivernormative:Device Types / I2C Adapter Device / Device Op=
eration}
> +\end{itemize}
> +
>  \conformance{\section}{Device Conformance}\label{sec:Conformance / Devic=
e Conformance}
> =20
>  A device MUST conform to the following normative statements:
> @@ -477,6 +489,14 @@ \section{Conformance Targets}\label{sec:Conformance =
/ Conformance Targets}
>  \item \ref{devicenormative:Device Types / Memory Device / Device Operati=
on / STATE request}
>  \end{itemize}
> =20
> +\conformance{\subsection}{I2C Adapter Device Conformance}\label{sec:Conf=
ormance / Device Conformance / I2C Adapter Device Conformance}
> +
> +An I2C Adapter device MUST conform to the following normative statements=
:
> +
> +\begin{itemize}
> +\item \ref{devicenormative:Device Types / I2C Adapter Device / Device Op=
eration}
> +\end{itemize}
> +
>  \conformance{\section}{Legacy Interface: Transitional Device and Transit=
ional Driver Conformance}\label{sec:Conformance / Legacy Interface: Transit=
ional Device and Transitional Driver Conformance}
>  A conformant implementation MUST be either transitional or
>  non-transitional, see \ref{intro:Legacy
> diff --git a/content.tex b/content.tex
> index 91855b4..95e2ed8 100644
> --- a/content.tex
> +++ b/content.tex
> @@ -6200,6 +6200,7 @@ \subsubsection{Legacy Interface: Framing Requiremen=
ts}\label{sec:Device
>  \input{virtio-iommu.tex}
>  \input{virtio-sound.tex}
>  \input{virtio-mem.tex}
> +\input{virtio-i2c.tex}
> =20
>  \chapter{Reserved Feature Bits}\label{sec:Reserved Feature Bits}
> =20
> diff --git a/virtio-i2c.tex b/virtio-i2c.tex
> new file mode 100644
> index 0000000..b631211
> --- /dev/null
> +++ b/virtio-i2c.tex
> @@ -0,0 +1,85 @@
> +\section{I2C Adapter Device}\label{sec:Device Types / I2C Adapter Device=
}
> +
> +virtio-i2c is a virtual I2C adapter device. It provides a way to flexibl=
y
> +organize and manage I2C slave devices from the guest. By attaching ACPI
> +I2C slave nodes to the virtual I2C adapter device, the guest can
> +communicate with them without changing or adding extra drivers for these
> +slave I2C devices.=20
> +
> +\subsection{Device ID}\label{sec:Device Types / I2C Adapter Device / Dev=
ice ID}
> +34
> +
> +\subsection{Virtqueues}\label{sec:Device Types / I2C Adapter Device / Vi=
rtqueues}
> +
> +\begin{description}
> +\item[0] requestq
> +\end{description}
> +
> +\subsection{Feature bits}\label{sec:Device Types / I2C Adapter Device / =
Feature bits}
> +
> +None currently defined.
> +
> +\subsection{Device configuration layout}\label{sec:Device Types / I2C Ad=
apter Device / Device configuration layout}
> +
> +None currently defined.
> +
> +\subsection{Device Initialization}\label{sec:Device Types / I2C Adapter =
Device / Device Initialization}
> +
> +\begin{enumerate}
> +\item The virtqueue is initialized.
> +\end{enumerate}
> +
> +\subsection{Device Operation}\label{sec:Device Types / I2C Adapter Devic=
e / Device Operation}
> +
> +The driver queues requests to the virtqueues, and they are used by the
> +device (not necessarily in order). Each request is of form:
> +
> +\begin{lstlisting}
> +struct virtio_i2c_req {
> +        le16 addr;
> +        le16 flags;
> +        le16 len;
> +        u8 buf[];
> +        u8 status;
> +};
> +\end{lstlisting}
> +
> +The \field{addr} is the address of the I2C slave device.
> +
> +The first bit of \field{flags} indicates whether it is a read or write r=
equest.
> +It mesns a read request if the first bit of \field{flags} is set, otherw=
ise


means

> +it is a write request. The rest bits of \field{flags} are reserved.

Do we really need this flg? write request is just a big write followed by 1
byte read, read request is write read 1 byte read.



> +The \field{len} of the request indicates the length of the I2C message.
> +
> +The \field{buf} of the request contains the I2C message. If the first bi=
t of
> +\field{flags} is '1', the \field{buf} is written by the device and it co=
ntains
> +the message read from the device. If the first bit of \field{flags} is '=
0', the
> +\field{buf} is written by the driver and it contains the message written=
 to the
> +the device.
> +
> +The final \field{status} byte is written by the device: either VIRTIO_I2=
C_MSG_OK
> +for success or VIRTIO_I2C_MSG_ERR for error.
> +
> +\begin{lstlisting}
> +#define VIRTIO_I2C_MSG_OK     0
> +#define VIRTIO_I2C_MSG_ERR    1
> +\end{lstlisting}
> +
> +\drivernormative{\subsubsection}{Device Operation}{Device Types / I2C Ad=
apter Device / Device Operation}
> +
> +A driver MUST set \field{addr}, \field{flags} and \field{len} before sen=
ding
> +the message.
> +
> +A driver MUST place the I2C message into \field{buf} if the first bit of
> +\field{flags} is '0'.
> +
> +A driver MUST NOT use the message if the final \field{status}


What does "use the message" mean? What message?
> return from the

> +device is VIRTIO_I2C_MSG_ERR.

returned?

> +
> +\devicenormative{\subsubsection}{Device Operation}{Device Types / I2C Ad=
apter Device / Device Operation}
> +
> +A device MUST NOT change the value of \field{addr}, \field{flags} and \f=
ield{len}.



> +
> +A device MUST place the message into \field{buf} if the first bit of \fi=
eld{flags}
> +is '1'.


again, what the message?


> \ No newline at end of file
> --=20
> 2.7.4
>=20
>=20
> This publicly archived list offers a means to provide input to the
> OASIS Virtual I/O Device (VIRTIO) TC.
>=20
> In order to verify user consent to the Feedback License terms and
> to minimize spam in the list archive, subscription is required
> before posting.
>=20
> Subscribe: virtio-comment-subscribe@lists.oasis-open.org
> Unsubscribe: virtio-comment-unsubscribe@lists.oasis-open.org
> List help: virtio-comment-help@lists.oasis-open.org
> List archive: https://lists.oasis-open.org/archives/virtio-comment/
> Feedback License: https://www.oasis-open.org/who/ipr/feedback_license.pdf
> List Guidelines: https://www.oasis-open.org/policies-guidelines/mailing-l=
ists
> Committee: https://www.oasis-open.org/committees/virtio/
> Join OASIS: https://www.oasis-open.org/join/


This publicly archived list offers a means to provide input to the
OASIS Virtual I/O Device (VIRTIO) TC.

In order to verify user consent to the Feedback License terms and
to minimize spam in the list archive, subscription is required
before posting.

Subscribe: virtio-comment-subscribe@lists.oasis-open.org
Unsubscribe: virtio-comment-unsubscribe@lists.oasis-open.org
List help: virtio-comment-help@lists.oasis-open.org
List archive: https://lists.oasis-open.org/archives/virtio-comment/
Feedback License: https://www.oasis-open.org/who/ipr/feedback_license.pdf
List Guidelines: https://www.oasis-open.org/policies-guidelines/mailing-lis=
ts
Committee: https://www.oasis-open.org/committees/virtio/
Join OASIS: https://www.oasis-open.org/join/

