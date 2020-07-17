Return-Path: virtio-dev-return-7580-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id C3917986096
	for <virtio-dev@lists.oasis-open.org>; Fri, 17 Jul 2020 09:26:44 +0000 (UTC)
Date: Fri, 17 Jul 2020 10:26:35 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20200717092635.GB128195@stefanha-x1.localdomain>
References: <20200518203721.7625-1-ndragazis@arrikto.com>
 <20200518203721.7625-2-ndragazis@arrikto.com>
 <87v9inv26c.fsf@linaro.org>
MIME-Version: 1.0
In-Reply-To: <87v9inv26c.fsf@linaro.org>
Subject: Re: [virtio-dev] [PATCH v5 01/10] vhost-user: add vhost-user device
 type
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="dTy3Mrz/UPE2dbVg"
Content-Disposition: inline
To: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Cc: Nikos Dragazis <ndragazis@arrikto.com>, "Michael S . Tsirkin" <mst@redhat.com>, virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

--dTy3Mrz/UPE2dbVg
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 16, 2020 at 05:45:47PM +0100, Alex Benn=E9e wrote:
> Nikos Dragazis <ndragazis@arrikto.com> writes:
> > diff --git a/virtio-vhost-user.tex b/virtio-vhost-user.tex
> > new file mode 100644
> > index 0000000..ac96dc2
> > --- /dev/null
> > +++ b/virtio-vhost-user.tex
> > @@ -0,0 +1,292 @@
> > +\section{Vhost-user Device Backend}\label{sec:Device Types / Vhost-use=
r Device Backend}
> > +
> > +The vhost-user device backend facilitates vhost-user device emulation =
through
> > +vhost-user protocol exchanges and access to shared memory.  Software-d=
efined
> > +networking, storage, and other I/O appliances can provide services thr=
ough this
> > +device.
> > +
> > +This section relies on definitions from the \hyperref[intro:Vhost-user
> > +Protocol]{Vhost-user Protocol}.  Knowledge of the vhost-user protocol =
is a
> > +prerequisite for understanding this device.
> > +
> > +The \hyperref[intro:Vhost-user Protocol]{Vhost-user Protocol} was orig=
inally
> > +designed for processes on a single system communicating over UNIX doma=
in
> > +sockets.  The virtio vhost-user device backend allows the vhost-user s=
lave to
> > +communicate with the vhost-user master over the device instead of a UN=
IX domain
> > +socket.  This allows the slave and master to run on two separate
> > systems such
>=20
> I realise we already have the terms master/slave baked into the
> vhost-user spec but perhaps we could find better wording? The vhost
> documentation describes thing in terms of who owns the virtqueues (the
> drive) and who processes the requests (the device). There may be better
> terminology to use.

"backend" is now commonly used instead of "slave". There is no new term
for "master" yet. I suggest replacing "slave" with "backend" in this
patch.

Using "device"/"driver" would cause confusion here because
both virtio-vhost-user itself and the vhost device being emulated
already use those terms. We need to be able to differentiate between the
vhost-level master/backend concept and the VIRTIO driver/device concept.

> > +as a virtual machine and a hypervisor.
>=20
> This implies type-2 setups, depending on where you define the
> hypervisor. Could the language be extended: " or device in one virtual
> machine with the driver operating in another"?

Traditional vhost-user looks like this:

       VM
   virtio-net

       |

      VMM                     vhost-user-net process
vhost-user master  ------------ vhost-user backend

The vhost-user protocol communication is not visible to the VM. It just
sees a virtio-net device.

With virtio-vhost-user it looks like this:

    Driver VM                      Device VM
virtio-net driver             virtio-vhost-user driver

       |                               |

   Driver VMM                      Device VMM
vhost-user master  ------------ vhost-user backend

Here the master is running on the "hypervisor" (it's the Driver VMM) and
the backend is running inside the Device VM.

This spec does not require that the Driver VMM and Device VMM
communicate over the traditional vhost-user UNIX domain socket.

I'm not sure what "device in one virtual machine with the driver
operating in another" means. The main point of the paragraph is that a
VIRTIO device for vhost-user allows the master and backend to run on
separate systems (no longer tied to a UNIX domain socket).

Can you think of a rewording that captures this better?

> > +\begin{description}
> > +\item[\field{status}] contains the vhost-user operational status.  The=
 default
> > +    value of this field is 0.
> > +
> > +    The driver sets VIRTIO_VHOST_USER_STATUS_SLAVE_UP to indicate read=
iness for
> > +    the vhost-user master to connect.  The vhost-user master cannot co=
nnect
> > +    unless the driver has set this bit first.
>=20
> I suspect some deployment diagrams are going to help here. Does this
> imply that there is something in userspace connected to the slave kernel
> ready to process messages or just that the driver in the kernel is ready
> to accept messages?

That is beyond the scope of the spec. There is no requirement for
implementing the virtio-vhost-user driver in the kernel or in userspace.

The existing implementation in DPDK/SPDK is a userspace VFIO PCI
implementation. The guest kernel in the Device VM does not touch the
virtio-vhost-user device.

Maybe someone will come up with a use-case where the device emulation
needs to happen in the guest kernel (e.g. the in-kernel SCSI target).

I think a kernel driver for virtio-vhost-user is not very useful since
the actual behavior happens in userspace and involves shared memory.
There is already an API for that VFIO. A userspace library would make it
nicer to use though.

But these are just my thoughts on how the Device VM's software stack
should look. This spec allows all approaches.

I do think it would be helpful to include an diagram/description in the
beginning of the spec with a concrete example of how the Device VM's
virtio-vhost-user software stack could look.

> > +The driver SHOULD place at least one buffer in rxq before setting the
> > +VIRTIO_VHOST_USER_SLAVE_UP bit in the \field{status} configuration
> > field.
>=20
> This is a buffer for use - not an initial message?

Yes, an empty buffer. The rxq needs to be populated with buffers so that
messages can be received from the master. Vhost-user messages are
initiated by the master so the backend does not send an initial message.

> > +The following additional resources exist:
> > +\begin{description}
> > +  \item[Doorbells] The driver signals the vhost-user master through do=
orbells.  The signal does not carry any data, it is purely an event.
> > +  \item[Notifications] The vhost-user master signals the driver for ev=
ents besides virtqueue activity and configuration changes by sending notifi=
cations.
>=20
> What is the difference between a doorbell and a notification?

Doorbells allow the driver to signal the device (i.e. device hardware
registers that the driver writes to).

Notifications allow the driver to be signalled by the device (i.e. MSI-X
interrupts that the driver handles).

The more abstract "doorbell" and "notification" terms are used instead
of hardware registers and interrupts because transports other than PCI
may want to support these features too.

> > +\subsubsection{Doorbell structure layout}\label{sec:Device Types / Vho=
st-user Device Backend / Additional Device Resources over PCI / Doorbell ca=
pability}
> > +
> > +The doorbell location is found using the VIRTIO_PCI_CAP_DOORBELL_CFG
> > +capability.  This capability is immediately followed by an additional
> > +field, like so:
> > +
> > +\begin{lstlisting}
> > +struct virtio_pci_doorbell_cap {
> > +        struct virtio_pci_cap cap;
> > +        le32 doorbell_off_multiplier;
> > +};
> > +\end{lstlisting}
>=20
> OK stuff is disappearing in later patches. Maybe it shouldn't be
> introduced in the first place?

I think Nikos sent the patches in this order to keep my authorship.

Nikos: Feel free to squash everything into one patch and add your
Signed-off-by. You can also set yourself as the author of the git
commit. As long as my Signed-off-by stays on the patch it indicates I
have given permission to use this text.

Stefan

--dTy3Mrz/UPE2dbVg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl8RbssACgkQnKSrs4Gr
c8jNQQf8CQ71/wijFackwC242L/ZXTNE3NkeK/dWQHT6YyZugnd5/r6cP+uJN0ER
SjmLJf1d2yA424TRsn+OCIwv5ahRgVvOPUPa83sGuEGDOuUOylF5llB8JsK+zCY1
9VPzvsJhSAfaubjUVl0qXnLZ1MrnCtZWiduM52DNCEr1z2N4BZKkCOnSb7PC6zN7
+F7bzGXp1WaCCE4VW1mP36LhQ1vO++qeFHHiPHezvRuRmtOFDdaPDXsAhPwAgfUn
ltyl0mCJUqW53oXcBHObypfoVbQfX4iBTVJMO0RQPQsx34BQJliOgJiA8LGI3cz9
sKmckSsN1aZXnH1uHW86TJcIKYINhg==
=UvS7
-----END PGP SIGNATURE-----

--dTy3Mrz/UPE2dbVg--

