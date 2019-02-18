Return-Path: virtio-dev-return-5452-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id BC501985B56
	for <virtio-dev@lists.oasis-open.org>; Mon, 18 Feb 2019 14:45:01 +0000 (UTC)
Date: Mon, 18 Feb 2019 14:44:48 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20190218144448.GC29625@stefanha-x1.localdomain>
References: <20190213063322.25099-1-stefanha@redhat.com>
 <20190213063322.25099-2-stefanha@redhat.com>
 <77591e8b-5147-fa0f-27f3-a1cb94c62550@redhat.com>
 <20190214033325.GD21877@stefanha-x1.localdomain>
 <CAOssrKdfYic5bSz-GkfZUbd=OrADwrVXPRTQiVgOFbzpiVwNZg@mail.gmail.com>
 <20190214083637.GC7652@stefanha-x1.localdomain>
 <CAOssrKcXftoaszAoNF3936rTP0KgD6mL4P=hoy54v2i+x-1o8A@mail.gmail.com>
 <20190218102049.GA12256@stefanha-x1.localdomain>
 <CAOssrKeZhTMbKET=MRjDpqmWNMj00b2MG4Gv6MY-kdKYf1=eyA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="uXxzq0nDebZQVNAZ"
Content-Disposition: inline
In-Reply-To: <CAOssrKeZhTMbKET=MRjDpqmWNMj00b2MG4Gv6MY-kdKYf1=eyA@mail.gmail.com>
Subject: Re: [virtio-dev] [PATCH v2 1/2] content: add virtio file system
 device
To: Miklos Szeredi <mszeredi@redhat.com>
Cc: virtio-dev@lists.oasis-open.org, Vivek Goyal <vgoyal@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Sage Weil <sweil@redhat.com>, Steven Whitehouse <swhiteho@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

--uXxzq0nDebZQVNAZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Feb 18, 2019 at 11:52:34AM +0100, Miklos Szeredi wrote:
> Indeed, inotify and friends would need notification support, but at
> the moment no network filesystem has that and the kernel doesn't have
> interfaces for filesystems to provide remote notifications, so this is
> quite theoretical at this point.

This discussion makes me more confident that virtio-fs doesn't need
notifications yet.

I will remove them from the spec.

Stefan

--uXxzq0nDebZQVNAZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJcasTgAAoJEJykq7OBq3PI7qQH+gLRAxDDF8npNHPLxNK8s1KY
ShWYnoHS32ZB5JD6RtaQ53XdeIaKPeAN4PV1InoUroOOw49gA0aPSoPxoi/sae+M
dJKUYoz0ptnFaeJBV/7jHovNBL4fnZ7TLWq0HXMe6uxW//CejcF2yiYlbVCIWcGZ
LwxNKQlPkfZcz8iyyjlzMNNbliAiYDXPq+HT1FY4rjLL7uKf02FVUkB2R+U5n06M
nlY09WipdICw49Y6yeEwWUsNYeh0UoFeCa5Qy6UEbOl9qB75WEgrJ4owB2jfZ1sq
a3OTC6dQvuMAr+NgaOr2XYsYhkd4M+fWWtXNKAeh2NwQUsFhrgDuRWAWRyOrP7c=
=a9/p
-----END PGP SIGNATURE-----

--uXxzq0nDebZQVNAZ--
