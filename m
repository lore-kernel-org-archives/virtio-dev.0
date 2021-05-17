Return-Path: virtio-dev-return-8163-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 93437985DDD
	for <virtio-dev@lists.oasis-open.org>; Mon, 17 May 2021 10:14:23 +0000 (UTC)
Date: Mon, 17 May 2021 11:14:16 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <YKJB+FNzjrE/y25F@stefanha-x1.localdomain>
References: <20210215095410.85607-1-stefanha@redhat.com>
 <20210215095410.85607-3-stefanha@redhat.com>
 <20210514163320.GA486352@horse>
MIME-Version: 1.0
In-Reply-To: <20210514163320.GA486352@horse>
Subject: [virtio-dev] Re: [PATCH v2 2/2] virtio-fs: add notification queue
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="z8O2bnuGLVTU3RqM"
Content-Disposition: inline
To: Vivek Goyal <vgoyal@redhat.com>
Cc: virtio-dev@lists.oasis-open.org, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, mszeredi@redhat.com
List-ID: <virtio-dev.lists.oasis-open.org>

--z8O2bnuGLVTU3RqM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 14, 2021 at 12:33:20PM -0400, Vivek Goyal wrote:
> On Mon, Feb 15, 2021 at 09:54:10AM +0000, Stefan Hajnoczi wrote:
> > The FUSE protocol allows the file server (device) to initiate
> > communication with the client (driver) using FUSE notify messages.
> > Normally only the client can initiate communication. This feature is
> > used to report asynchronous events that are not related to an in-flight
> > request.
> >=20
> > This patch adds a notification queue that works like an rx queue in
> > other VIRTIO device types. The device can emit FUSE notify messages by
> > using a buffer from this queue.
> >=20
> > This mechanism was designed by Vivek Goyal <vgoyal@redhat.com>.
> >=20
> > Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> > ---
> >  conformance.tex |  1 +
> >  virtio-fs.tex   | 71 ++++++++++++++++++++++++++++++++++++++++++-------
> >  2 files changed, 62 insertions(+), 10 deletions(-)
> >=20
> > diff --git a/conformance.tex b/conformance.tex
> > index 9a7fe0b..8c2f511 100644
> > --- a/conformance.tex
> > +++ b/conformance.tex
> > @@ -227,6 +227,7 @@ \section{Conformance Targets}\label{sec:Conformance=
 / Conformance Targets}
> >  \begin{itemize}
> >  \item \ref{drivernormative:Device Types / File System Device / Device =
configuration layout}
> >  \item \ref{drivernormative:Device Types / File System Device / Device =
Operation / Device Operation: High Priority Queue}
> > +\item \ref{drivernormative:Device Types / File System Device / Device =
Operation / Device Operation: Notification Queue}
> >  \item \ref{drivernormative:Device Types / File System Device / Device =
Operation / Device Operation: DAX Window}
> >  \end{itemize}
> > =20
> > diff --git a/virtio-fs.tex b/virtio-fs.tex
> > index 158d066..c995748 100644
> > --- a/virtio-fs.tex
> > +++ b/virtio-fs.tex
> > @@ -25,24 +25,33 @@ \subsection{Virtqueues}\label{sec:Device Types / Fi=
le System Device / Virtqueues
> > =20
> >  \begin{description}
> >  \item[0] hiprio
> > -\item[1\ldots n] request queues
> > +\item[1] notification queue
> > +\item[2\ldots n] request queues
> >  \end{description}
> > =20
> > +The notification queue only exists if VIRTIO_FS_F_NOTIFICATION is set.
>=20
> Hi Stefan,
>=20
> Say device is new enough that it sets Feature bit, VIRTIO_FS_F_NOTIFICATI=
ON
> but driver is old and does not understand this feature. I am assuming for
> these cases protocol allows for feature negotiation and if driver does no=
t
> acknowledge VIRTIO_FS_F_NOTIFICATION feature, then queue at index 1, will
> be a request queue and not notification queue?

Yes, exactly. The virtqueue layout is only decided when feature
negotiation completes. If the driver did not enable
VIRTIO_FS_F_NOTIFICATION then the bit will be cleared and virtqueues
will use the traditional layout without a notification queue.

> > +
> >  \subsection{Feature bits}\label{sec:Device Types / File System Device =
/ Feature bits}
> > =20
> > -There are currently no feature bits defined.
> > +\begin{description}
> > +\item[VIRTIO_FS_F_NOTIFICATION (0)] Device has support for FUSE notify
> > +    messages.  The notification queue is virtqueue 1.
> > +\end{description}
> > =20
> >  \subsection{Device configuration layout}\label{sec:Device Types / File=
 System Device / Device configuration layout}
> > =20
> > -All fields of this configuration are always available.
> > -
> >  \begin{lstlisting}
> >  struct virtio_fs_config {
> >          char tag[36];
> >          le32 num_request_queues;
> > +        le32 notify_buf_size;
> >  };
> >  \end{lstlisting}
> > =20
> > +The \field{tag} and \field{num_request_queues} fields are always avail=
able.
> > +The \field{notify_buf_size} field is only available when
> > +VIRTIO_FS_F_NOTIFICATION is set.
> > +
> >  \begin{description}
> >  \item[\field{tag}] is the name associated with this file system.  The =
tag is
> >      encoded in UTF-8 and padded with NUL bytes if shorter than the
> > @@ -53,6 +62,8 @@ \subsection{Device configuration layout}\label{sec:De=
vice Types / File System De
> >      there are no ordering guarantees between requests made available o=
n
> >      different queues.  Use of multiple queues is intended to increase
> >      performance.
> > +\item[\field{notify_buf_size}] is the minimum number of bytes required=
 for each
> > +    buffer in the notification queue.
> >  \end{description}
> > =20
> >  \drivernormative{\subsubsection}{Device configuration layout}{Device T=
ypes / File System Device / Device configuration layout}
> > @@ -65,13 +76,20 @@ \subsection{Device configuration layout}\label{sec:=
Device Types / File System De
> > =20
> >  The device MUST set \field{num_request_queues} to 1 or greater.
> > =20
> > +The device MUST set \field{notify_buf_size} to be large enough to hold=
 any of
> > +the FUSE notify messages that this device emits.
> > +
> >  \subsection{Device Initialization}\label{Device Types / File System De=
vice / Device Initialization}
> > =20
> > -On initialization the driver first discovers the device's virtqueues. =
 The FUSE
> > -session is started by sending a FUSE\_INIT request as defined by the F=
USE
> > -protocol on one request virtqueue.  All virtqueues provide access to t=
he same
> > -FUSE session and therefore only one FUSE\_INIT request is required reg=
ardless
> > -of the number of available virtqueues.
> > +On initialization the driver first discovers the device's virtqueues.
> > +
> > +The driver populates the notification queue with buffers for receiving=
 FUSE
> > +notify messages if VIRTIO_FS_F_NOTIFICATION is set.
> > +
> > +The FUSE session is started by sending a FUSE\_INIT request as defined=
 by the
> > +FUSE protocol on one request virtqueue.  All virtqueues provide access=
 to the
> > +same FUSE session and therefore only one FUSE\_INIT request is require=
d
> > +regardless of the number of available virtqueues.
> > =20
> >  \subsection{Device Operation}\label{sec:Device Types / File System Dev=
ice / Device Operation}
> > =20
> > @@ -88,7 +106,8 @@ \subsection{Device Operation}\label{sec:Device Types=
 / File System Device / Devi
> >        full.
> >  \end{itemize}
> > =20
> > -Note that FUSE notification requests are not supported.
> > +FUSE notify messages are received on the notification queue if
> > +VIRTIO_FS_F_NOTIFICATION is set.
> > =20
> >  \subsubsection{Device Operation: Request Queues}\label{sec:Device Type=
s / File System Device / Device Operation / Device Operation: Request Queue=
s}
> > =20
> > @@ -179,6 +198,38 @@ \subsubsection{Device Operation: High Priority Que=
ue}\label{sec:Device Types / F
> > =20
> >  The driver MUST anticipate that request queues are processed concurren=
tly with the hiprio queue.
> > =20
> > +\subsubsection{Device Operation: Notification Queue}\label{sec:Device =
Types / File System Device / Device Operation / Device Operation: Notificat=
ion Queue}
> > +
> > +The notification queue is populated with buffers by the driver and the=
se
> > +buffers are used by the device to emit FUSE notify messages.  Notifica=
tion
> > +queue buffer layout is as follows:
> > +
> > +\begin{lstlisting}
> > +struct virtio_fs_notify {
> > +        // Device-writable part
> > +        struct fuse_out_header out_hdr;
> > +        char outarg[notify_buf_size - sizeof(struct fuse_out_header)];
> > +};
> > +\end{lstlisting}
> > +
> > +\field{outarg} contains the FUSE notify message payload that depends o=
n the
> > +type of notification being emitted.
> > +
> > +If the driver provides notification queue buffers at a slower rate tha=
n the
> > +device emits FUSE notify messages then the virtqueue will eventually b=
ecome
> > +empty.  The behavior in response to an empty virtqueue depends on the =
FUSE
> > +notify message type:
>=20
> So we are right now definiting the behavior of only one notification
> message, FUSE_NOTIFY_LOCK. Others will be filled later? Or it will be
> left to device implementation.

Others will be added to the spec when their use with virtiofs is defined.

> > +\begin{itemize}
> > +\item FUSE\_NOTIFY\_LOCK messages are delivered when buffers become av=
ailable again. When the device runs out of resources new lock requests fail=
 with ENOLCK.
>=20
> So device should check for available notification buffer every time a loc=
k
> request comes in to make sure atleast one buffer is available. But it is
> possible that 5 requests come and only 1 notification buffer is available
> and they all will succeed. And by the time lock is available, 4
> notifications will still have to wait.=20
>=20
> IOW, we probably should define the notion of buffering of events in=20
> device and deliver to driver when notification buffers are available.
> And leave it to device when should it start returning ENOLOCK. Some
> devices might decide to buffer X number of notifications and if number
> of buffered notifications cross X, then start returning ENOLOCK.

I'll reword this part because that's exactly what I meant: the device
has internal resources for blocking FUSE_NOTIFY_LOCK messages. These are
internal resources, they are separate from the empty/full state of the
notification queue. The device will refuse to accept new blocking lock
requests with ENOLCK if it runs out of internal resources.

> I guess we have to return ENOLOCK only for waiting lock messages
> (F_SETLKW). For non-blocking locks, we will immediately return either wit=
h
> lock held or with error EACCESS or EAGAIN.
>=20
> > +\end{itemize}
> > +
> > +\drivernormative{\paragraph}{Device Operation: Notification Queue}{Dev=
ice Types / File System Device / Device Operation / Device Operation: Notif=
ication Queue}
> > +
> > +The driver MUST provide buffers of at least \field{notify_buf_size} by=
tes.
> > +
> > +The driver SHOULD replenish notification queue buffers sufficiently qu=
ickly so
> > +that there is always at least one available buffer.
>=20
> I am wondering how can driver ensure that there is always atleast one
> available buffer. Its possible driver is still processing all
> notifications and leaving a brief interval where notification queue
> is empty. IOW, dirvers can try but can't guarantee this, I guess.

Yes, that is why SHOULD is used instead of MUST. It's a best-effort
thing and the behavior for running out of resources is defined above
(FUSE_NOTIFY_LOCK have device internal resources associated with them so
they can wait for new notification queue buffers to become available
without dropping notifications).

Stefan

--z8O2bnuGLVTU3RqM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmCiQfgACgkQnKSrs4Gr
c8iqKgf/Vvz0t54sx2M6IsR7cBCqdOW4Myx7AGE5duhTrASme79LN5h786xgJgNp
MN5RU/hZnteN9xjNLeRJXyrpex+4H92/PJf1QciACJ3y1R82P0ajVTL8T347WE50
7Hjl8JfUHFWvPdlL5X24Lk0pj2vP0p8aoNSLn4Fm9Yg6cCiKGRTlFT6LAQRu5xC/
omD5F262VOygMMEocigMjLbgD3Tx7luKKXtdk7372OhN7GpKMRmD4MG5u4D3a2KB
ENm6SPjY2UPA6dfgNzoS+E1SgqP6jjvp0sW+XNVw193NnssXgD4tRljB16qBvQ5O
mErFxZznV5gFtkbiY6qkYpZouaog9g==
=i6+V
-----END PGP SIGNATURE-----

--z8O2bnuGLVTU3RqM--

