Return-Path: <david@redhat.com>
Message-ID: <b95d3aab-21c0-8256-a8bd-09e5b45cd206@redhat.com>
Date: Wed, 11 Jan 2023 15:14:10 +0100
MIME-Version: 1.0
Subject: Re: [virtio-dev] [PATCH v3 06/20] virtio-mem-balloon: Maintain mem
 balloon device spec in separate directory
References: <20230110230358.528098-1-parav@nvidia.com>
 <20230110230358.528098-7-parav@nvidia.com>
From: David Hildenbrand <david@redhat.com>
In-Reply-To: <20230110230358.528098-7-parav@nvidia.com>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: Parav Pandit <parav@nvidia.com>, mst@redhat.com, virtio-dev@lists.oasis-open.org, cohuck@redhat.com
Cc: virtio-comment@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

On 11.01.23 00:03, Parav Pandit wrote:
> Move virtio memory balloon device specification to its own file
> similar to recent virtio devices.
> While at it, place device specification, its driver and device
> conformance into its own directory to have self contained device
> specification.
> 
> Fixes: https://github.com/oasis-tcs/virtio-spec/issues/153
> Signed-off-by: Parav Pandit <parav@nvidia.com>
>

There is virtio-mem and there is virtio-balloon. Calling virtio-balloon 
"virtio-mem-balloon" can easily lead to quite some confusion. Any 
particular reason why not to stick to "virtio-balloon" ?

-- 
Thanks,

David / dhildenb

