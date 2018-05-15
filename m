Return-Path: virtio-return-3102-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio@lists.oasis-open.org>
List-Post: <mailto:virtio@lists.oasis-open.org>
List-Help: <mailto:virtio-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-subscribe@lists.oasis-open.org>
Date: Tue, 15 May 2018 09:51:40 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20180515085140.GU5182@stefanha-x1.localdomain>
References: <1524740402-18934-1-git-send-email-pasic@linux.ibm.com>
 <1524740402-18934-5-git-send-email-pasic@linux.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="0iexB5Bk8cF8G6DP"
Content-Disposition: inline
In-Reply-To: <1524740402-18934-5-git-send-email-pasic@linux.ibm.com>
Subject: Re: [virtio] [PATCH 4/6] pci: map common notifications terminology
 to PCI
To: Halil Pasic <pasic@linux.ibm.com>
Cc: virtio@lists.oasis-open.org, virtio-dev@lists.oasis-open.org, "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Pawel Moll <pawel.moll@arm.com>
List-ID: <virtio-dev.lists.oasis-open.org>

--0iexB5Bk8cF8G6DP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 26, 2018 at 01:00:00PM +0200, Halil Pasic wrote:
> @@ -1306,14 +1306,15 @@ enough to ensure that the separate parts of the v=
irtqueue are on
>  separate cache lines.
>  }.  There was no mechanism to negotiate the queue size.
> =20
> -\subsubsection{Notifying The Device}\label{sec:Virtio Transport Options =
/ Virtio Over PCI Bus / PCI-specific Initialization And Device Operation / =
Notifying The Device}
> +\subsubsection{Available Buffer Notifications}\label{sec:Virtio Transpor=
t Options / Virtio Over PCI Bus / PCI-specific Initialization And Device Op=
eration / Available Buffer Notifications}
> =20
> -The driver notifies the device by writing the 16-bit virtqueue index
> +The driver sends an available buffer notification the device by writing

s/notification the/notification to the/

--0iexB5Bk8cF8G6DP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJa+p+cAAoJEJykq7OBq3PIlA8IAJ30Diwk/MKQUqAWqzP1i34H
qssT0Fj2iPO9Hg+R8OQv+pstcaU3ZHSUF1cYo8hnv1+AFkibJP8W5S7vmAmGbykn
h5FJoRxwz45dsqS+DoZhYPUCWBpEILFCjr3RyuzonNZ3Ha5VWMV1A9H2UReo0xEB
qE+FjccHiQpUJMdOp2tqKYJZ1USpct1vR3YfnAQaKMlER9+xBN8LlYUJa9hqID0h
7nEsCqkJ+ZbVql0ks/mjaGvqMcUASM6PC/AF4SPjY9ob12nowvtFgAZUl+mL13hq
amA/DAZ2J8gUTG656W/Qm0Gw5mkv7uvPvGRmnp+ecrJgROpOG3Gz4SQN90WcMxs=
=xm+r
-----END PGP SIGNATURE-----

--0iexB5Bk8cF8G6DP--
