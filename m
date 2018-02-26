Return-Path: virtio-dev-return-3284-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id AE3905818F80
	for <virtio-dev@lists.oasis-open.org>; Mon, 26 Feb 2018 09:50:52 -0800 (PST)
From: "Rustad, Mark D" <mark.d.rustad@intel.com>
Date: Mon, 26 Feb 2018 17:48:15 +0000
Message-ID: <E8D91EBA-F75D-4FF9-BDE8-FCE3A4B4B007@intel.com>
References: <20180226044837.19543.12267.stgit@mdrustad-mac04.local>
 <CAKgT0UcMth9Jxovoj7xo0q2t+MuY0K1Upf+Mqs3zgXdriui-tA@mail.gmail.com>
In-Reply-To: <CAKgT0UcMth9Jxovoj7xo0q2t+MuY0K1Upf+Mqs3zgXdriui-tA@mail.gmail.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3EF8EE341FE89847A02E31C769C6A168@intel.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [virtio-dev] Re: [RFC PATCH V4] pci: virtio_pci: Add SR-IOV support for
 virtio_pci devices
To: Alexander Duyck <alexander.duyck@gmail.com>
Cc: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, Netdev <netdev@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, "Daly, Dan" <dan.daly@intel.com>, Alex Williamson <alex.williamson@redhat.com>, "MRustad@gmail.com" <MRustad@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

Alex,

> On Feb 26, 2018, at 7:26 AM, Alexander Duyck <alexander.duyck@gmail.com> =
wrote:
>=20
> Mark,
>=20
> In the future please don't put my "Reviewed-by" on a patch that I
> haven't reviewed. I believe I reviewed one of the earlier patches, but
> I hadn't reviewed this version.

I'm very sorry. I completely spaced doing something about that. I think you=
rs was the first Reviewed-by I ever had in this way. In the future I will r=
emove such things from my changelog right after sending. Thanks for alertin=
g me to what I had failed to do.

> Also, after thinking about it over the weekend we may want to look at
> just coming up with a truly "generic" solution that is applied to
> SR-IOV capable devices that don't have a SR-IOV capable driver loaded
> on them. That would allow us to handle the uio, vfio, pci-stub, and
> virtio cases all in one fell swoop. I think us going though and
> modifying one patch at a time to do this kind of thing isn't going to
> scale.

The notion of that kind of troubles me - at least pci-stub does. Having wor=
ked on ixgbe a bit, I have to wonder what kind of havoc would ensue if an i=
xgbe device were assigned to a guest, and an attempt was made to allocate V=
Fs by the pci-stub. The guest could be running any version of the ixgbe dri=
ver, possibly even an old one that didn't support SR-IOV. Even if it did su=
pport SR-IOV, I don't know how it would respond to mailbox messages when it=
 doesn't think it has VFs.

> I'll try to do some digging and find the VFIO approach we had been
> working on. I think with a couple tweaks we can probably make that
> truly generic and ready for submission.

I'd like to know more about you are thinking about.

--=20
Mark Rustad, Networking Division, Intel Corporation


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

