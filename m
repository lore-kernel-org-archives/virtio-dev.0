Return-Path: virtio-comment-return-824-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
From: "Huang, Yang" <yang.huang@intel.com>
Date: Tue, 30 Jul 2019 05:51:24 +0000
Message-ID: <0B92A36466FABC4D99BAF0BDB1FA8BBC4157267E@shsmsx102.ccr.corp.intel.com>
References: <1564386494-2296-1-git-send-email-yang.huang@intel.com>
 <1564386494-2296-2-git-send-email-yang.huang@intel.com>
 <20190729104802-mutt-send-email-mst@kernel.org>
In-Reply-To: <20190729104802-mutt-send-email-mst@kernel.org>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: RE: [virtio-comment] Re: [PATCH] Add virtio rpmb device
 specification
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>, "Zhu, Bing" <bing.zhu@intel.com>, "Winkler, Tomas" <tomas.winkler@intel.com>
List-ID: <virtio-dev.lists.oasis-open.org>


Let me give a simple introduction on RPMB operation.

This is the RPMB frame for request and response:
Stuff       | Key/MAC |   Data  |  Nonce | Write Counter | Address | Block =
Count | Result | Req/Resp
196B               32B          256B        16B                4B          =
          2B                  2B                 2B            2B
[511:316][315:284]   [283:28]  [27:12]          [11:8]              [7:6]  =
            [5:4]              [3:2]       [1:0]

Guest will fill this RPMB frame per request and send it to driver. Driver t=
hen format it to vqueue and send to device.
After device receive it, it will parse the frame, do authentication and fil=
l a new frame with the result, data, MAC, Resp etc.
The new frame will be responded to driver for guest.


> > @@ -183,6 +183,14 @@ \section{Conformance
> > Targets}\label{sec:Conformance / Conformance Targets}  \item
> > \ref{drivernormative:Device Types / Socket Device / Device Operation /
> > Device Events}  \end{itemize}
> >
> > +\conformance{\subsection}{RPMB Driver
> > +Conformance}\label{sec:Conformance / Driver Conformance / RPMB Driver
> > +Conformance}
> > +
> > +A RPMB driver MUST conform to the following normative statements:
> > +
> > +\begin{itemize}
> > +\item \ref{drivernormative:Device Types / RPMB Device / Device
> > +Operation} \end{itemize}
> > +
> >  \conformance{\section}{Device Conformance}\label{sec:Conformance /
> > Device Conformance}
> >
> >  A device MUST conform to the following normative statements:
> > @@ -338,6 +346,14 @@ \section{Conformance
> > Targets}\label{sec:Conformance / Conformance Targets}  \item
> > \ref{devicenormative:Device Types / Socket Device / Device Operation /
> > Receive and Transmit}  \end{itemize}
> >
> > +\conformance{\subsection}{RPMB Device
> > +Conformance}\label{sec:Conformance / Device Conformance / RPMB Device
> > +Conformance}
> > +
> > +An RPMB device MUST conform to the following normative statements:
> > +
> > +\begin{itemize}
> > +\item \ref{devicenormative:Device Types / RPMB Device / Device
> > +Operation} \end{itemize}
> > +
>=20
> Sorry this is not how we do it. Device and driver conformance are separat=
e
> sections, labeled appropriately. Device Operation should include general =
prose
> that explains how they fit together.
>
> >  \conformance{\section}{Legacy Interface: Transitional Device and
> > Transitional Driver Conformance}\label{sec:Conformance / Legacy
> > Interface: Transitional Device and Transitional Driver Conformance}  A
> > conformant implementation MUST be either transitional or
> > non-transitional, see \ref{intro:Legacy diff --git a/content.tex
> > b/content.tex index ee0d7c9..7f54f94 100644
> > --- a/content.tex
> > +++ b/content.tex
> > @@ -2717,6 +2717,8 @@ \chapter{Device Types}\label{sec:Device Types}
> > \hline
> >  27         &   PMEM device \\
> >  \hline
> > +28         &   RPMB device \\
> > +\hline
> >  \end{tabular}
> >
> >  Some of the devices above are unspecified by this document, @@
> > -5677,6 +5679,7 @@ \subsubsection{Legacy Interface: Framing
> > Requirements}\label{sec:Device  \input{virtio-input.tex}
> > \input{virtio-crypto.tex}  \input{virtio-vsock.tex}
> > +\input{virtio-rpmb.tex}
> >
> >  \chapter{Reserved Feature Bits}\label{sec:Reserved Feature Bits}
> >
> > diff --git a/virtio-rpmb.tex b/virtio-rpmb.tex new file mode 100644
> > index 0000000..b0b9ae1
> > --- /dev/null
> > +++ b/virtio-rpmb.tex
> > @@ -0,0 +1,88 @@
> > +\section{RPMB Device}\label{sec:Device Types / RPMB Device}
> > +
> > +virtio-rpmb is a virtio based RPMB (Replay Protected Memory Block)
> > +device. It is used as a tamper-resistant and anti-replay storage.
> > +It supports four command requests including read, write, get write
> > +counter and program key. They are placed in the queue.
> > +
> > +\subsection{Device ID}\label{sec:Device Types / RPMB Device / Device
> > +ID}
> > +
> > +28
> > +
> > +\subsection{Virtqueues}\label{sec:Device Types / RPMB Device /
> > +Virtqueues}
> > +
> > +\begin{description}
> > +\item[0] requestq
> > +\end{description}
> > +
> > +\subsection{Feature bits}\label{sec:Device Types / RPMB Device /
> > +Feature bits}
> > +
> > +None.
> > +
> > +\subsection{Device configuration layout}\label{sec:Device Types /
> > +RPMB Device / Device configuration layout}
> > +
> > +None.
> > +
> > +\subsection{Device Initialization}\label{sec:Device Types / RPMB
> > +Device / Device Initialization}
>=20
> Below and everywhere, each conformance statement belongs to either device
> or driver, listing either device or driver and moved to the appropriate
> conformance section.

OK. Thanks.

> > +
> > +\begin{enumerate}
> > +\item The virtqueue is initialized.
> > +\item The authentication key of device SHOULD NOT be programmed at the
> first initialization.
>=20
> what does this imply exactly? what is "first initialization"? first after=
 which event?
> device reset?
>=20
> > +\item The device size SHOULD be initialized to a multiple of 128 Kbyte=
s and up
> to 16Mbytes.
>=20
> what is device size and how does it affect operation?

It refers to the capacity of RPMB. I will change the wording.
It is the rule in Spec. So keep consistent with hardware.
For RPMB, the block size is 256B, and the address is UINT16.
So the max capacity is 256B * 2^16 =3D 16MB.
Invalid address access will be returned with a VIRTIO_RPMB_RES_AUTH_FAILURE=
 defined below.

> > +\end{enumerate}
> > +
> > +\subsection{Device Operation}\label{sec:Device Types / RPMB Device /
> > +Device Operation}
> > +
> > +The operation of a virtio RPMB device is driven by the requests placed=
 on the
> virtqueue.
> > +  The type of the request can be program key
> > +(VIRTIO_RPMB_REQ_PROGRAM_KEY),
> > +  get write counter (VIRTIO_RPMB_REQ_GET_WRITE_COUNTER),
> > +  write (VIRTIO_RPMB_REQ_DATA_WRITE), and read
> (VIRTIO_RPMB_REQ_DATA_READ).
> > +  A program key or write request can also combine with a
> > +  result read (VIRTIO_RPMB_REQ_RESULT_READ) for a returned result.
> > +
> > +\begin{lstlisting}
> > +#define VIRTIO_RPMB_REQ_PROGRAM_KEY        0x0001
> > +#define VIRTIO_RPMB_REQ_GET_WRITE_COUNTER  0x0002
> > +#define VIRTIO_RPMB_REQ_DATA_WRITE         0x0003
> > +#define VIRTIO_RPMB_REQ_DATA_READ          0x0004
> > +#define VIRTIO_RPMB_REQ_RESULT_READ        0x0005
> > +\end{lstlisting}
>=20
> OK but what are these numbers in aid of? Does driver pass these values to=
 the
> device somehow?

The numbers are used as request type (Req/Resp) in RPMB frame to specify a =
operation on RPMB like read/write/get writer counter/program key.
Driver will pass the whole data frame to device.

> > +
> > +\drivernormative{\subsubsection}{Device Operation}{Device Types /
> > +RPMB Device / Device Operation}
> > +
> > +The driver MUST configure and initialize all virtqueues for the reques=
ts
> received.
> > +
> > +\devicenormative{\subsubsection}{Device Operation}{Device Types /
> > +RPMB Device / Device Operation}
> > +
> > +The device provides a simulated RPMB backed by ordinary file or
> > +  other medium in host. It SHOULD keep consistent behaviors with
> > +  hardware, including but not limited to:
> > +\begin{enumerate}
> > +\item The device maintains a monotonic write counter and an
> > +   authentication key. Once the first successful key programming
> > +   is performed, the authentication key MUST be kept unchanged
> > +   during device lifecycle. The monotonic write counter MUST be
> > +   added by one automatically after each successful write operation.
> > +\item The RPMB device cannot be accessed until RPMB authentication
>=20
> until after?

Yes. After.

> > +   key is programmed.
>=20
> and until device reset?

After RPMB authentication key is successful programmed, it will be saved by=
 device and kept unchanged regardless of device reset or reboot.

> >For any operation (read, write, program key,
> > +   get write counter) done to virtio RPMB device after authentication
> > +   key is programmed successfully, the device responds with a MAC
> > +   calculated by authentication key with HMAC-SHA to driver.
>=20
> responds how?

it is filled to the MAC of RPMB frame. And the frame is responded to driver=
.

> > +\item The device MUST authenticate write operation by MAC calculated
> > +   by authentication key and monotonic write counter .
>=20
> authenticate how?

1. compare the monotonic write counter in RPMB frame with the one recorded =
in device. Make sure the two values are equal. This counter protects from r=
eplay attack.
2. calculate the MAC by RPMB key(recorded by device at the first program ke=
y request from guest) and the RPMB frame received from driver. Compare this=
 MAC with the MAC in RPMB frame. Make sure the two MACs are same. It protec=
ts data from tampering by the attacks who doesn't have RPMB key.
After 1&2 are authenticated, a write operation will be performed.

Should include these details into spec?

> > +\end{enumerate}
> > +
> > +One of the below error codes MUST be returned to the driver
> > +  based on the operation result.
>=20
> how are they returned to driver?

Device puts the error code to the Result of RPMB frame and pass the data fr=
ame to driver.

> > +
> > +\begin{lstlisting}
> > +#define VIRTIO_RPMB_RES_OK                     0x0000
> > +#define VIRTIO_RPMB_RES_GENERAL_FAILURE        0x0001
> > +#define VIRTIO_RPMB_RES_AUTH_FAILURE           0x0002
> > +#define VIRTIO_RPMB_RES_COUNT_FAILURE          0x0003
> > +#define VIRTIO_RPMB_RES_ADDR_FAILURE           0x0004
> > +#define VIRTIO_RPMB_RES_WRITE_FAILURE          0x0005
> > +#define VIRTIO_RPMB_RES_READ_FAILURE           0x0006
> > +#define VIRTIO_RPMB_RES_NO_AUTH_KEY            0x0007
> > +#define VIRTIO_RPMB_RES_WRITE_COUNTER_EXPIRED  0x0080
> > +\end{lstlisting}



This publicly archived list offers a means to provide input to the=0D
OASIS Virtual I/O Device (VIRTIO) TC.=0D
=0D
In order to verify user consent to the Feedback License terms and=0D
to minimize spam in the list archive, subscription is required=0D
before posting.=0D
=0D
Subscribe: virtio-comment-subscribe@lists.oasis-open.org=0D
Unsubscribe: virtio-comment-unsubscribe@lists.oasis-open.org=0D
List help: virtio-comment-help@lists.oasis-open.org=0D
List archive: https://lists.oasis-open.org/archives/virtio-comment/=0D
Feedback License: https://www.oasis-open.org/who/ipr/feedback_license.pdf=0D
List Guidelines: https://www.oasis-open.org/policies-guidelines/mailing-lists=0D
Committee: https://www.oasis-open.org/committees/virtio/=0D
Join OASIS: https://www.oasis-open.org/join/

