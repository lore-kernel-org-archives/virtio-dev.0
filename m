Return-Path: virtio-dev-return-7611-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 0C88D985DD7
	for <virtio-dev@lists.oasis-open.org>; Thu, 23 Jul 2020 06:15:24 +0000 (UTC)
Date: Thu, 23 Jul 2020 07:15:13 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20200723061513.GA268427@stefanha-x1.localdomain>
References: <20200518203721.7625-1-ndragazis@arrikto.com>
 <20200518203721.7625-2-ndragazis@arrikto.com>
 <87v9inv26c.fsf@linaro.org>
 <20200717092635.GB128195@stefanha-x1.localdomain>
 <99b30044-f59c-c9b7-df3a-3a1eb4001042@arrikto.com>
MIME-Version: 1.0
In-Reply-To: <99b30044-f59c-c9b7-df3a-3a1eb4001042@arrikto.com>
Subject: Re: [virtio-dev] [PATCH v5 01/10] vhost-user: add vhost-user device
 type
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="YZ5djTAD1cGYuMQK"
Content-Disposition: inline
To: Nikos Dragazis <ndragazis@arrikto.com>
Cc: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>, "Michael S . Tsirkin" <mst@redhat.com>, virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

--YZ5djTAD1cGYuMQK
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 17, 2020 at 02:17:13PM +0300, Nikos Dragazis wrote:
> On 17/7/20 12:26 =CE=BC.=CE=BC., Stefan Hajnoczi wrote:
>=20
> > On Thu, Jul 16, 2020 at 05:45:47PM +0100, Alex Benn=C3=A9e wrote:
> > > Nikos Dragazis <ndragazis@arrikto.com> writes:
> > > > diff --git a/virtio-vhost-user.tex b/virtio-vhost-user.tex
> > > > new file mode 100644
> > > > index 0000000..ac96dc2
> > > > --- /dev/null
> > > > +++ b/virtio-vhost-user.tex
> > > > @@ -0,0 +1,292 @@
> > > > +\section{Vhost-user Device Backend}\label{sec:Device Types / Vhost=
-user Device Backend}
> > > > +
> > > > +The vhost-user device backend facilitates vhost-user device emulat=
ion through
> > > > +vhost-user protocol exchanges and access to shared memory.  Softwa=
re-defined
> > > > +networking, storage, and other I/O appliances can provide services=
 through this
> > > > +device.
> > > > +
> > > > +This section relies on definitions from the \hyperref[intro:Vhost-=
user
> > > > +Protocol]{Vhost-user Protocol}.  Knowledge of the vhost-user proto=
col is a
> > > > +prerequisite for understanding this device.
> > > > +
> > > > +The \hyperref[intro:Vhost-user Protocol]{Vhost-user Protocol} was =
originally
> > > > +designed for processes on a single system communicating over UNIX =
domain
> > > > +sockets.  The virtio vhost-user device backend allows the vhost-us=
er slave to
> > > > +communicate with the vhost-user master over the device instead of =
a UNIX domain
> > > > +socket.  This allows the slave and master to run on two separate
> > > > systems such
> > > I realise we already have the terms master/slave baked into the
> > > vhost-user spec but perhaps we could find better wording? The vhost
> > > documentation describes thing in terms of who owns the virtqueues (th=
e
> > > drive) and who processes the requests (the device). There may be bett=
er
> > > terminology to use.
> > "backend" is now commonly used instead of "slave". There is no new term
> > for "master" yet. I suggest replacing "slave" with "backend" in this
> > patch.
>=20
> Makes sense. Some observations:
>=20
> 1. Since "backend" is used instead of "slave", why "frontend" is not
> =C2=A0=C2=A0 used instead of "master"? Also, why does the vhost-user spec=
 use the
> =C2=A0=C2=A0 terms"slave" and "backend" interchangeably and doesn't just =
drop the
> =C2=A0=C2=A0 term"slave"completely?

Using "frontend" and "backend" sounds good. Do you want to send a patch
to qemu.git docs/interop/vhost-user.rst?

The vhost-user spec grew organically and few people have spent time on
polishing it, making it consistent, etc.

Stefan

--YZ5djTAD1cGYuMQK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl8ZKvEACgkQnKSrs4Gr
c8hyJgf9EHI0rf2bC+7Px79wKoDQnozRKsQXQTJmRKWQ2ETY6rwKz5eNTlMncPW2
B3L2A9HqIxAeVZ8Qmix/acM8xK5RYwfk27spsS9z1KxFLUS0KO/2/n4hQnAZ9pms
1C/ecDyaYcaBCwzqY1BwXhTaqUIztzbDHZPso7lhMlzVqnqP2z1qB8dW1wi2A8tj
ZTV7rn4WpiauktuD2T631LLuP8Fy+UgSaQ2O+YmtdST2CCyz4Z9sXHhgWIOYHXrT
N/uR26dOO7lBAfyASmuywhcwW6e0X7ywBilJ8YzZyru22CBozlb1zx5k1H5pMD4S
gKwlZZQp7nRkFTY5qHZoS4vqaPYSpA==
=lD+y
-----END PGP SIGNATURE-----

--YZ5djTAD1cGYuMQK--

