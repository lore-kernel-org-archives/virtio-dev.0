Return-Path: <alvaro.karsz@solid-run.com>
MIME-Version: 1.0
References: <20230206080210.37758-1-alvaro.karsz@solid-run.com>
 <CAJs=3_C5AqOtaKjk_OWrG+U8SUFLSMez=-6M4JQsh3EEazj-KQ@mail.gmail.com> <PH0PR12MB54815E20847C0A5EAF4EEC35DCDE9@PH0PR12MB5481.namprd12.prod.outlook.com>
In-Reply-To: <PH0PR12MB54815E20847C0A5EAF4EEC35DCDE9@PH0PR12MB5481.namprd12.prod.outlook.com>
From: Alvaro Karsz <alvaro.karsz@solid-run.com>
Date: Sat, 11 Feb 2023 11:12:34 +0200
Message-ID: <CAJs=3_B=veAoNPoLKkqtHcApajVn=82UzVfw63gr7YY+0J3m-w@mail.gmail.com>
Subject: Re: [virtio-dev] Re: [PATCH v3] virtio-net: Mention
 VIRTIO_NET_F_HASH_REPORT dependency on VIRTIO_NET_F_CTRL_VQ
Content-Type: text/plain; charset="UTF-8"
To: Parav Pandit <parav@nvidia.com>
Cc: "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "jasowang@redhat.com" <jasowang@redhat.com>, "mst@redhat.com" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

> I missed your previous response.
> Sorry for the late response.

No problem at all :)

> Why cannot device say as MUST requirement?
>
> Let say there is a device out that exposes a F_HASH_REPORT without F_CTRL_VQ.
> So driver tried to send a command and failed to issue cmd.
> End result, hash config was not successful.
> Did driver gain anything from seeing supplied hash in the config space?
> No. it just confused driver that device offered feature bit, could see the supposed hash, but still couldn't configure it.
>
> So, I think the right fix is that device MUST NOT set F_HASH_REPORT without F_CTRL_VQ.
>
> And driver should .. is fine, because existing driver that followed 1.2 will negotiate, and device will also accept it if it offered without F_CTRL_VQ.
>
> Any new device that follows 1.3 will not offer F_HAS_REPORT without C_VQ, hence it cannot be negotiated by driver without C_VQ.
>
> The gain is : device doesn't need to continue offering F_HASH_REPORT without C_VQ. And I doubt if any device would have done it, as it was obvious.
> Just the spec was missed out.
>
> Is MUST/SHOULD big deal here for device? At least not to me, from practical standpoint to me.
> Making must just makes the spec consistent with rest without breaking backward compat.

The first version of this patch [1] actually used a bit requirement
(which is equivalent to a "MUST" if I understand correctly).
Then Michael pointed out that we can't do it since a version was
published without this requirement.

It's clear that the control VQ is required to use this feature.
In the linux kernel implementation probe will fail if a device offers
F_HASH_REPORT without F_CTRL_VQ.

Ideally we'll add a "MUST", but since we can't, our options are to
have a "SHOULD", or not mention the dependency at all.

[1] https://lists.oasis-open.org/archives/virtio-comment/202302/msg00026.html

