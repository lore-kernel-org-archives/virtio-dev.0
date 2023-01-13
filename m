Return-Path: <david@redhat.com>
Message-ID: <88ab958d-31e0-d348-cd46-8b820bd8e1c7@redhat.com>
Date: Fri, 13 Jan 2023 11:53:33 +0100
MIME-Version: 1.0
Subject: Re: [PATCH v4 06/20] virtio-mem-balloon: Maintain mem balloon device
 spec in separate directory
References: <20230112212254.763783-1-parav@nvidia.com>
 <20230112212254.763783-7-parav@nvidia.com>
From: David Hildenbrand <david@redhat.com>
In-Reply-To: <20230112212254.763783-7-parav@nvidia.com>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: Parav Pandit <parav@nvidia.com>, mst@redhat.com, virtio-dev@lists.oasis-open.org, cohuck@redhat.com
Cc: virtio-comment@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

On 12.01.23 22:22, Parav Pandit wrote:
> Move virtio memory balloon device specification to its own file
> similar to recent virtio devices.
> While at it, place device specification, its driver and device
> conformance into its own directory to have self contained device
> specification.
> 
> Fixes: https://github.com/oasis-tcs/virtio-spec/issues/153
> Signed-off-by: Parav Pandit <parav@nvidia.com>

Nit: Subject s/virtio-mem-balloon/virtio-balloon/

Thanks!

-- 
Thanks,

David / dhildenb

