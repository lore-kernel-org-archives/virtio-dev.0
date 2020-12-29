Return-Path: virtio-comment-return-1609-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
Date: Tue, 29 Dec 2020 11:09:34 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20201229110934.GA55616@stefanha-x1.localdomain>
References: <ff3ec9f5cb7f480a52913790f698ad45c66edcc2.1608796685.git.jie.deng@intel.com>
MIME-Version: 1.0
In-Reply-To: <ff3ec9f5cb7f480a52913790f698ad45c66edcc2.1608796685.git.jie.deng@intel.com>
Subject: Re: [virtio-comment] [PATCH v6] virtio-i2c: add the device
 specification
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="YiEDa0DAkWCtVeE4"
Content-Disposition: inline
To: Jie Deng <jie.deng@intel.com>
Cc: virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org, mst@redhat.com, cohuck@redhat.com, pbonzini@redhat.com, kraxel@redhat.com, wsa+renesas@sang-engineering.com, andriy.shevchenko@linux.intel.com, conghui.chen@intel.com, yu1.wang@intel.com, shuo.a.liu@intel.com
List-ID: <virtio-dev.lists.oasis-open.org>

--YiEDa0DAkWCtVeE4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Dec 24, 2020 at 04:10:43PM +0800, Jie Deng wrote:
> +\subsection{Device Operation}\label{sec:Device Types / I2C Adapter Device / Device Operation}
> +
> +\subsubsection{Device Operation: Request Queue}\label{sec:Device Types / I2C Adapter Device / Device Operation: Request Queue}
> +
> +The driver queues requests to the virtqueue, and they are used by the
> +device. The request is the representation of segments of an I2C
> +transaction. Each request is of the form:
> +
> +\begin{lstlisting}
> +struct virtio_i2c_out_hdr {
> +        le16 addr;
> +        le16 padding;
> +        le32 flags;
> +};
> +\end{lstlisting}
> +
> +\begin{lstlisting}
> +struct virtio_i2c_in_hdr {
> +        u8 status;
> +};
> +\end{lstlisting}
> +
> +\begin{lstlisting}
> +struct virtio_i2c_req {
> +        struct virtio_i2c_out_hdr out_hdr;
> +        u8 write_buf[];
> +        u8 read_buf[];
> +        struct virtio_i2c_in_hdr in_hdr;
> +};
> +\end{lstlisting}
> +
> +The \field{addr} of the request is the address of the I2C controlled device.
> +The format of \field{addr} is defined in paragraph 3.1.10 and 3.1.11 of
> +\hyperref[intro:I2C]{I2C}.

It's still unclear how addresses are represented in le16 addr even after
reading the I2C paragraphs mentioned above.

Here is my guess:

le16 addr  15 14 13 12 11 10  9  8  7  6  5  4  3  2  1  0
7-bit       0  0  0  0  0  0  0  0  A6 A5 A4 A3 A2 A1 A0 0
10-bit     A7 A6 A5 A4 A3 A2 A1 A0   1  1  1  1  0 A9 A8 0

The R/W bit is ignored and always set to 0 since the I/O direction is
already implicit in the size of write_buf[] and read_buf[].

Is this correct? Please document the exact layout in the virtio spec
since the I2C spec does not describe an le16 representation.

> +
> +The \field{padding} is used to pad to full dword.
> +
> +The \field{flags} of the request is currently reserved as zero for future
> +feature extensibility.
> +
> +The \field{write_buf} of the request contains one segment of an I2C transaction
> +being written to the device.
> +
> +The \field{read_buf} of the request contains one segment of an I2C transaction
> +being read from the device.
> +
> +The final \field{status} byte of the request is written by the device: either
> +VIRTIO_I2C_MSG_OK for success or VIRTIO_I2C_MSG_ERR for error.
> +
> +\begin{lstlisting}
> +#define VIRTIO_I2C_MSG_OK     0
> +#define VIRTIO_I2C_MSG_ERR    1
> +\end{lstlisting}
> +
> +If ``length of \field{read_buf}''=0 and ``length of \field{write_buf}''>0,
> +the request is called write request.
> +
> +If ``length of \field{read_buf}''>0 and ``length of \field{write_buf}''=0,
> +the request is called read request.
> +
> +If ``length of \field{read_buf}''>0 and ``length of \field{write_buf}''>0,
> +the request is called write-read request. It means an I2C write segment followed
> +by a read segment. Usually, the write segment provides the number of an I2C
> +controlled device register to be read.
> +
> +The case when ``length of \field{write_buf}''=0, and at the same time,
> +``length of \field{read_buf}''=0 doesn't make any sense.
> +
> +\subsubsection{Device Operation: Operation Status}\label{sec:Device Types / I2C Adapter Device / Device Operation: Operation Status}
> +
> +\field{addr}, ``length of \field{write_buf}'' and ``length of \field{read_buf}''
> +are determined by the driver, while \field{status} is determined by the processing
> +of the devcie. A driver puts the data written to the device into \field{write_buf}, while

s/devcie/device/

> +a device puts the data of the corresponding length into \field{read_buf} according the
> +request of the driver.
> +
> +A driver may send one request or multiple requests to the device at a time.
> +The requests in the virtqueue are both queued and processed in order.
> +
> +If a driver sends multiple requests at a time and a device fails to process
> +some of them, then the first failed request will have its \field{status}
> +being set to VIRTIO_I2C_MSG_ERR by the device and the requests after the first
> +failed one will also be treated as VIRTIO_I2C_MSG_ERR by the driver,
> +no matter what \field{status} of them. In this case, the number of successfully
> +sent requests this time is the number of the last request being successfully
> +processed.

If I understand correctly all requests submitted in a single available
buffer notification are grouped together. Once the first request fails
the driver must treat all remaining requests as failed?

Devices may poll vrings instead of using available buffer notifications.
Polled devices cannot provide the grouping semantics described above.

If you want to group requests then it is necessary to include a
per-request group ID or continuation/end-of-group field. virtio-net
VIRTIO_NET_F_MRG_RXBUF is an example of this.

Additionally, this paragraph does not specify whether the device
executes the remaining requests or not. This seems problematic to me
because the driver does not know which requests actually executed when
a request in a group of requests fails?

> +
> +\drivernormative{\subsubsection}{Device Operation}{Device Types / I2C Adapter Device / Device Operation}
> +
> +A driver MUST set \field{addr} and \field{flags} before sending the request.
> +
> +A driver MUST set \field{flags} to be zero.
> +
> +The driver SHOULD never send a request with ``length of \field{write_buf}''=0 and
> +``length of \field{read_buf}''=0 at the same time.

s/SHOULD never/MUST NOT/?

> +
> +A driver MUST NOT use \field{read_buf} if the final \field{status} returned
> +from the device is VIRTIO_I2C_MSG_ERR.
> +
> +A driver MAY queue one request or multiple requests at a time.

I think no other VIRTIO device only allows one request queued at a time.
Therefore it's probably not necessary to include this statement - all
devices allow one or more requests to be queued at a time.

--YiEDa0DAkWCtVeE4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl/rDmsACgkQnKSrs4Gr
c8jCGggAwYd23cgjqzdgvleLvMRGU/DxbFdREJZvh/44AI1t8z2nzUnyBiKN/kf3
TMPc5fMvzoT7afUifAnjwwYnE3RTxW2IqB4MPOmu0FCeEgFpxKeSw0YhnmzQ/VOe
0QNApyeRxCz6p2vElrhbRhVsbd+gO9JcyMWZ/+2XeAbrKoujs5wzga5VxrskaZLg
bdArGdyMzPgfzf4ZmgkzXFI/WRT6jTh/vED86lfQgjbUHuxRyFCFP98VA1jwffaI
crUg5CcgbGizNbtfWvz+yDCGOB8mKFZploiPPII55iobJXsDUeSswCdrG+E/a+Q0
L1xhlDDvPW9BM4/g7mK9BpupQBdp+w==
=0ziP
-----END PGP SIGNATURE-----

--YiEDa0DAkWCtVeE4--

