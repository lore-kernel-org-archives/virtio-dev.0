Return-Path: virtio-comment-return-1555-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
Date: Wed, 16 Dec 2020 18:38:59 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20201216183859.1e7b206a.cohuck@redhat.com>
In-Reply-To: <1ea117ebe46d105eda21544acf85a5c7dbe2d8ec.1606283457.git.jie.deng@intel.com>
References: <1ea117ebe46d105eda21544acf85a5c7dbe2d8ec.1606283457.git.jie.deng@intel.com>
MIME-Version: 1.0
Subject: Re: [virtio-comment] [PATCH v5] virtio-i2c: add the device
 specification
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
To: Jie Deng <jie.deng@intel.com>
Cc: virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org, mst@redhat.com, pbonzini@redhat.com, kraxel@redhat.com, wsa+renesas@sang-engineering.com, andriy.shevchenko@linux.intel.com, conghui.chen@intel.com, yu1.wang@intel.com, shuo.a.liu@intel.com
List-ID: <virtio-dev.lists.oasis-open.org>

On Wed, 25 Nov 2020 13:55:18 +0800
Jie Deng <jie.deng@intel.com> wrote:

<some mostly editorial comments; sorry about bringing this up now>

> virtio-i2c is a virtual I2C adapter device. It provides a way
> to =EF=AC=82exibly communicate with the host I2C slave devices from

s/=EF=AC=82exibly/flexibly/

> the guest.
>=20
> This patch adds the specification for this device.
>=20
> Fixes: https://github.com/oasis-tcs/virtio-spec/issues/88
> Signed-off-by: Jie Deng <jie.deng@intel.com>
> ---
>  conformance.tex  |  28 +++++++++--
>  content.tex      |   1 +
>  introduction.tex |   3 ++
>  virtio-i2c.tex   | 139 +++++++++++++++++++++++++++++++++++++++++++++++++=
++++++
>  4 files changed, 167 insertions(+), 4 deletions(-)
>  create mode 100644 virtio-i2c.tex
>=20

(...)


> diff --git a/introduction.tex b/introduction.tex
> index cc38e29..9f016d5 100644
> --- a/introduction.tex
> +++ b/introduction.tex
> @@ -73,6 +73,9 @@ \section{Normative References}\label{sec:Normative Refe=
rences}
>  =09\phantomsection\label{intro:HDA}\textbf{[HDA]} &
>  =09High Definition Audio Specification,
>  =09\newline\url{https://www.intel.com/content/dam/www/public/us/en/docum=
ents/product-specifications/high-definition-audio-specification.pdf}\\
> +=09\phantomsection\label{intro:I2C}\textbf{[I2C]} &
> +=09I2C-bus specification and user manual,
> +=09\newline\url{https://www.nxp.com.cn/docs/en/user-guide/UM10204.pdf}\\

I think this url should use www.nxp.com instead of www.nxp.com.cn (even
though both seem to lead to the same document).

> =20
>  \end{longtable}
> =20
> diff --git a/virtio-i2c.tex b/virtio-i2c.tex
> new file mode 100644
> index 0000000..fdb0050
> --- /dev/null
> +++ b/virtio-i2c.tex
> @@ -0,0 +1,139 @@
> +\section{I2C Adapter Device}\label{sec:Device Types / I2C Adapter Device=
}
> +
> +virtio-i2c is a virtual I2C adapter device. It provides a way to flexibl=
y
> +organize and use the host I2C slave devices from the guest. By attaching
> +the host ACPI I2C slave nodes to the virtual I2C adapter device, the gue=
st can
> +communicate with them without changing or adding extra drivers for these
> +slave I2C devices.=20

I know that the i2c spec talks about 'slave' devices, but can we find a
better terminology for the virtio standard? E.g. prefix this with

"Note: This standard uses the term 'controlled I2C device' to refer to
what the I2C standard calls 'slave I2C device'."

(Or whatever better term might exist.)

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
> +\subsubsection{Device Operation: Request Queue}\label{sec:Device Types /=
 I2C Adapter Device / Device Operation: Request Queue}
> +
> +The driver queues requests to the virtqueue, and they are used by the
> +device. The request is the representation of segments of an I2C
> +transaction. Each request is of form:
> +
> +\begin{lstlisting}
> +struct virtio_i2c_req {
> +        le16 addr;
> +        le32 flags;
> +        le16 written;
> +        le16 read;
> +        u8 write_buf[];
> +        u8 read_buf[];
> +        u8 status;
> +};
> +\end{lstlisting}
> +
> +The \field{addr} of the request is the address of the I2C slave device.
> +
> +The \field{flags} of the request is currently reserved as zero for futur=
e
> +feature extensibility.
> +
> +The \field{written} of the request is the number of data bytes in the \f=
ield{write_buf}
> +being written to the I2C slave address.
> +
> +The \field{read} of the request is the number of data bytes in the \fiel=
d{read_buf}
> +being read from the I2C slave address.
> +
> +The \field{write_buf} of the request contains one segment of an I2C tran=
saction
> +being written to the device.
> +
> +The \field{read_buf} of the request contains one segment of an I2C trans=
action
> +being read from the device.
> +
> +The final \field{status} byte of the request is written by the device: e=
ither
> +VIRTIO_I2C_MSG_OK for success or VIRTIO_I2C_MSG_ERR for error.
> +
> +\begin{lstlisting}
> +#define VIRTIO_I2C_MSG_OK     0
> +#define VIRTIO_I2C_MSG_ERR    1
> +\end{lstlisting}
> +
> +If the \field{read}=3D0 and the \field{written}>0, the request is called=
 write request.
> +
> +If the \field{read}>0 and the \field{written}=3D0, the request is called=
 read request.
> +
> +If the \field{read}>0 and the \field{written}>0, the request is called w=
rite-read request.
> +It means an I2C write segment followed by a read segment. Usually, the w=
rite segment
> +provides the number of an I2C slave device register to be read.
> +
> +The \field{read}=3D0 and at the same time the \field{written}=3D0 doesn'=
t make any sense.
> +The driver SHOULD never send such request.

'SHOULD' makes this a normative statement.

> +
> +\subsubsection{Device Operation: Operation Status}\label{sec:Device Type=
s / I2C Adapter Device / Device Operation: Operation Status}
> +
> +A driver may send one request or multiple requests to the device at a ti=
me.
> +The requests in the virtqueue MUST be queued and processed in order.

Same here, 'MUST' makes this a normative statement. I think lowercasing
these terms would make it correct.

> +
> +If a driver sends multiple requests at a time and a device fails to proc=
ess
> +some of them, then the first failed request MUST have its \field{status}
> +being set to VIRTIO_I2C_MSG_ERR by the device and the requests after the=
 first
> +failed one MUST also be treated as VIRTIO_I2C_MSG_ERR by the driver,
> +no matter what \field{status} of them. In this case, the number of succe=
ssfully
> +sent requests this time is the number of the last request being successf=
ully
> +processed.
> +
> +\drivernormative{\subsubsection}{Device Operation}{Device Types / I2C Ad=
apter Device / Device Operation}
> +
> +A driver MUST set \field{addr}, \field{flags}(currently reserved as zero=
),

I'd drop "(currently reserved as zero)" here and add

"A driver MUST set \field{flags} to zero."


> +\field{written} and \field{read} before sending the request.
> +
> +A driver MUST place one segment of an I2C transaction into \field{write_=
buf} if the

s/if the/if/

> +\field{written}>0. =20
> +
> +A driver MUST NOT use \field{read_buf} if the final \field{status} retur=
ned
> +from the device is VIRTIO_I2C_MSG_ERR.
> +
> +A driver MAY queue one request or multiple requests at a time.
> +
> +A driver MUST queue the requests in order if multiple requests are going=
 to
> +be sent at a time.
> +
> +If multiple requests are sent at a time and some of them returned from t=
he
> +device have the \field{status} being VIRTIO_I2C_MSG_ERR, a driver MUST t=
reat
> +the first failed request and the requests after the first failed one as
> +VIRTIO_I2C_MSG_ERR.
> +
> +\devicenormative{\subsubsection}{Device Operation}{Device Types / I2C Ad=
apter Device / Device Operation}
> +
> +A device SHOULD keep consistent behaviors with the hardware as described=
 in
> +\hyperref[intro:I2C]{I2C}.
> +
> +A device MUST NOT change the value of \field{addr}, \field{flags}, \fiel=
d{written},
> +\field{read} and \field{write_buf}.
> +
> +A device MUST place one segment of an I2C transaction into \field{read_b=
uf} if the

s/if/if the/

> +\field{read}>0. =20
> +
> +A device MUST guarantee the requests in the virtqueue being processed in=
 order
> +if multiple requests are received at a time.
> +
> +If multiple requests are received at a time and some of them being proce=
ssed failed,
> +a device MUST set the \field{status} of the first failed request to be
> +VIRTIO_I2C_MSG_ERR and MAY set the \field{status} of the requests after
> +the first failed one to be VIRTIO_I2C_MSG_ERR.


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
Feedback License: https://www.oasis-open.org/who/ipr/feedback_license.pdf=
=0D
List Guidelines: https://www.oasis-open.org/policies-guidelines/mailing-lis=
ts=0D
Committee: https://www.oasis-open.org/committees/virtio/=0D
Join OASIS: https://www.oasis-open.org/join/

