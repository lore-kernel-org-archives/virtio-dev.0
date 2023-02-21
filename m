Return-Path: <hengqi@linux.alibaba.com>
Message-ID: <913230f2-24bc-a2b0-1a5e-c0f1414f888d@linux.alibaba.com>
Date: Wed, 22 Feb 2023 01:17:25 +0800
MIME-Version: 1.0
Subject: Re: [virtio-comment] RE: [virtio-dev] RE: [virtio-comment] RE: [PATCH
 v9] virtio-net: support inner header hash
References: <20230218143715.841-1-hengqi@linux.alibaba.com>
 <PH0PR12MB5481224CBC059BD482347133DCA59@PH0PR12MB5481.namprd12.prod.outlook.com>
 <9ff76a6e-fd77-4cf3-a9ad-546696ab843d@linux.alibaba.com>
 <PH0PR12MB5481E635794E2B63B9A110A3DCA59@PH0PR12MB5481.namprd12.prod.outlook.com>
 <f7080485-e8bd-048f-b8ea-cd86757f7b1c@linux.alibaba.com>
 <PH0PR12MB548135774CD69A5A5F475FB2DCA59@PH0PR12MB5481.namprd12.prod.outlook.com>
 <85de2618-6018-5436-6e8a-4d5253b42e64@linux.alibaba.com>
 <PH0PR12MB5481DFE61340CB9ACED1DEEADCA59@PH0PR12MB5481.namprd12.prod.outlook.com>
From: Heng Qi <hengqi@linux.alibaba.com>
In-Reply-To: <PH0PR12MB5481DFE61340CB9ACED1DEEADCA59@PH0PR12MB5481.namprd12.prod.outlook.com>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
To: Parav Pandit <parav@nvidia.com>, "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Yuri Benditovich <yuri.benditovich@daynix.com>, Cornelia Huck <cohuck@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>
List-ID: <virtio-dev.lists.oasis-open.org>



在 2023/2/22 上午12:50, Parav Pandit 写道:
>> From: Heng Qi <hengqi@linux.alibaba.com>
>> Sent: Tuesday, February 21, 2023 11:44 AM
>>> Patch-1 to introduce the feature bit, description, and link to CVQ dependency.
>>> Patch-2 for its link in virtio_net_config structure and description.
>>> Patch-3 for new command touching control VQ pieces.
>> Yes, and you seem to have missed my other replies in this thread:), I rephrased
> Was it comment "And virtio_net_hash_config seems to suffice except for le16 reserved[4]." ?
> I don’t see these reserved fields in the current structure.
>
>> it here:
>> virtio_net_hash_config seems to be reusable, as the v9 patch is doing, why
>> don't we re-use it?
>> The reason I can think of is to not expand the virtio_net_hash_config structure,
>> just set a separate structure for VIRTIO_NET_F_HASH_TUNNEL and include
>> hash_tunnel_types?
> The part that I am missing is, how do to reuse virtio_net_hash_config and say ignore all the existing fields related to rss, but only consider hash_tunnel_types?

Are you referring to such a command?

#define VIRTIO_NET_CTRL_HASH_TUNNEL_TYPE 1
struct virtio_net_tunnel_type_config {
      le32 hash_tunnel_types;
};

Thanks.

