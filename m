Return-Path: <virtio-dev-return-9378-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 5D828986231
	for <virtio-dev@lists.oasis-open.org>; Mon,  4 Apr 2022 10:06:14 +0000 (UTC)
Date: Mon, 4 Apr 2022 11:06:08 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <YkrDEMl+nxRJQFyr@stefanha-x1.localdomain>
References: <20220330152659.3780600-1-usama.arif@bytedance.com>
 <20220330152659.3780600-2-usama.arif@bytedance.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="H/YXl6ONCvcmSjoW"
Content-Disposition: inline
In-Reply-To: <20220330152659.3780600-2-usama.arif@bytedance.com>
Subject: [virtio-dev] Re: [PATCH 1/4] content: Introduce driver/device auxiliary
 notifications
To: Usama Arif <usama.arif@bytedance.com>
Cc: virtio-dev@lists.oasis-open.org, mst@redhat.com, ndragazis@arrikto.com, fam.zheng@bytedance.com, liangma@liangbit.com
List-ID: <virtio-dev.lists.oasis-open.org>

--H/YXl6ONCvcmSjoW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Mar 30, 2022 at 04:26:56PM +0100, Usama Arif wrote:
> +Available buffer notifications and device auxiliary notifications
> +are sent by the driver, the recipient is the device. Available buffer
> +notifications indicate that a buffer may have been made available on the
> +virtqueue designated by the notification; device auxiliary
> +notifcations allow the driver to send notifcations other than available

s/notifcations/notifications/

Please spell-check these commits.

--H/YXl6ONCvcmSjoW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmJKwxAACgkQnKSrs4Gr
c8h63Qf+Ok9dc+1WoB0zKyozpT7lb2IvhrzWkSlISO7cv8sUUSfP8KsDxUEObVOL
TL/9KL2zvBXVWvsT+tgLqO+59B5LFN95/eU6Z1bt6Nep2aVWGHzpMdh+JzvvEq6T
lwp+PjVuDiirtBLGiQkygRoAK+UqchmiuQN1+RrZoVEhmKV4mqGEbhyykq9RIKr1
e/YYBKthFa0NK4pZIb5qwgwgu9UDuwB77q3KZV3GaUlqOwB2fcapv73wLFLKMILy
UHTEL9+p0XswAWJE0KHdpDjqisMC08iyUz/ob1+cXKMtIYrQyupT9MHDHQc7HsJv
M+4Lo89OcSu4M4Lc3dnen5ba/fnm3g==
=zysz
-----END PGP SIGNATURE-----

--H/YXl6ONCvcmSjoW--

