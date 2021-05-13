Return-Path: virtio-dev-return-8161-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 7D1FA986475
	for <virtio-dev@lists.oasis-open.org>; Thu, 13 May 2021 14:46:28 +0000 (UTC)
Date: Thu, 13 May 2021 15:46:22 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <YJ07vrCt3thO5MM/@stefanha-x1.localdomain>
References: <CABATKF9Vjf1NE0EjToKfp=1aPcGieeny1k8rkfVv6BFZ=+b4sw@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CABATKF9Vjf1NE0EjToKfp=1aPcGieeny1k8rkfVv6BFZ=+b4sw@mail.gmail.com>
Subject: Re: [virtio-dev] [PATCH] Add virtio parameter server device
 specification
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="5ce6xITVt2DKj1fK"
Content-Disposition: inline
To: Hao Chen <chenhaosjtuacm@google.com>
Cc: virtio-dev@lists.oasis-open.org, Enrico Granata <egranata@google.com>
List-ID: <virtio-dev.lists.oasis-open.org>

--5ce6xITVt2DKj1fK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Apr 20, 2021 at 05:33:17PM -0700, Hao Chen wrote:
> This patch introduces a new type of device: parameter server. The device
> acts as a key-value store and the driver can read from, write to or
> subscribe to the properties in the server.

Can you share a bit about the reason for defining a new VIRTIO device
instead of running an existing key-value store over virtio-vsock or
virtio-net?

I'm not against adding this new device but I would like to understand
what the advantages are.

Thanks,
Stefan

--5ce6xITVt2DKj1fK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmCdO74ACgkQnKSrs4Gr
c8j+3ggAhPOEQ/WXUsC2P4cbi17oaC3GnOwzkzRj1W7CgohsmpKmVf4lD7rjs7Wp
ELTLG7t99BxD2IPiVx2GkuY6hrYm9RZdjpszZiEtWPDVDJ5hxMuAE7SAVHw8ZPDw
l/LsRLyUZ8mcwic3/fl00tOxDQ36Jd9Xg7UtTBJFAHe/fWmh7O4FvsGQcJVXevuN
mSYwcMFJ5UWcSMPoxfobKnthl60kmLXwZvbUsZO73H3XUApjDughNDWvyO5HqYtw
/7pOGhr3uNS8JjiVTiXrLCcldmkGbK4Dotyf0ng6bnYkbvFAbHHRje83AxrJ5FIs
634JFVOQP6qtcaWF7TARymqgXTbcUQ==
=apqq
-----END PGP SIGNATURE-----

--5ce6xITVt2DKj1fK--

