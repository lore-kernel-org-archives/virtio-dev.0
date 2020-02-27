Return-Path: virtio-dev-return-6792-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 5FBE6985E3A
	for <virtio-dev@lists.oasis-open.org>; Thu, 27 Feb 2020 04:21:03 +0000 (UTC)
MIME-Version: 1.0
References: <20200207182842.770bfb27@collabora.com> <20200225162105.1912fae0@collabora.com>
In-Reply-To: <20200225162105.1912fae0@collabora.com>
From: David Stevens <stevensd@chromium.org>
Date: Thu, 27 Feb 2020 13:20:51 +0900
Message-ID: <CAD=HUj5R_iOsCwaN85_nNUxo+3sp+QxR6bjPknqFM2Y+u0GOUg@mail.gmail.com>
Subject: Re: [virtio-dev] [RFC] Upstreaming virtio-wayland (or an alternative)
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
To: Boris Brezillon <boris.brezillon@collabora.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Zach Reizner <zachr@chromium.org>, =?UTF-8?Q?St=C3=A9phane_Marchesin?= <marcheu@chromium.org>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, Tomasz Figa <tfiga@chromium.org>, virtio-dev@lists.oasis-open.org, Alexandros Frantzis <alexandros.frantzis@collabora.co.uk>
List-ID: <virtio-dev.lists.oasis-open.org>

> * manage a central UUID <-> 'struct file' map that allows virtio-pipe
>   to convert FDs to UUIDs, pass UUIDs through a pipe and convert those
>   UUIDs back to FDs on the other end
>   - we need to expose an API to let each subsystem register/unregister
>     their UUID <-> FD mapping (subsystems are responsible for the UUID
>     creation/negotiation)

Can you provide more detail about the envisioned scope of this
framework? What sort of FDs and subsystems will use the framework? How
do operations on the guest FD affect the host FD, and vice versa?

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

