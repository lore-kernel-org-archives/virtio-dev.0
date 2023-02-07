Return-Path: <virtio-dev-return-10733-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id F10AC986434
	for <virtio-dev@lists.oasis-open.org>; Tue,  7 Feb 2023 07:55:19 +0000 (UTC)
MIME-Version: 1.0
References: <20230206080210.37758-1-alvaro.karsz@solid-run.com> <PH0PR12MB5481B6E2510FB242B76BBB30DCDA9@PH0PR12MB5481.namprd12.prod.outlook.com>
In-Reply-To: <PH0PR12MB5481B6E2510FB242B76BBB30DCDA9@PH0PR12MB5481.namprd12.prod.outlook.com>
From: Alvaro Karsz <alvaro.karsz@solid-run.com>
Date: Tue, 7 Feb 2023 09:54:41 +0200
Message-ID: <CAJs=3_DLyT4111_H57ESOPfrO=_WoJ5LEm4-NXygm8YYeNuRZg@mail.gmail.com>
Subject: Re: [virtio-dev] [PATCH v3] virtio-net: Mention VIRTIO_NET_F_HASH_REPORT
 dependency on VIRTIO_NET_F_CTRL_VQ
Content-Type: text/plain; charset="UTF-8"
To: Parav Pandit <parav@nvidia.com>
Cc: "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "jasowang@redhat.com" <jasowang@redhat.com>, "mst@redhat.com" <mst@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

Hi Parav,

> > +A driver SHOULD NOT negotiate VIRTIO_NET_F_HASH_REPORT if it does not
> > +negotiate VIRTIO_NET_F_CTRL_VQ.
> > +
> Same for the driver too.
> Like below.
> The driver should not negotiate a feature that requires to use a control VQ when VIRTIO_NET_F_CTRL_VQ is not negotiated.

The dependency of VIRTIO_NET_F_HASH_REPORT on VIRTIO_NET_F_CTRL_VQ is
not mentioned in the spec (directly at least).
So I'm not so sure about this line.

All the dependencies are listed in the "Feature bit requirements" section.
VIRTIO_NET_F_HASH_REPORT is missing, but since 1.2 is out, we can't
add it now as a requirement [1] [2].

[1] https://github.com/oasis-tcs/virtio-spec/issues/158
[2] https://lists.oasis-open.org/archives/virtio-comment/202302/msg00027.html

> Or driver must not .. ..
> Exception to that is VIRTIO_NET_F_HASH_REPORT, which driver should avoid negotiation ...

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

