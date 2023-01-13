Return-Path: <david@redhat.com>
Message-ID: <4dbacfa2-9c2c-f5ee-8def-4e9c25de7fc2@redhat.com>
Date: Fri, 13 Jan 2023 13:26:26 +0100
MIME-Version: 1.0
Subject: Re: [PATCH v4 00/20] Split device spec to its individual files
References: <20230112212254.763783-1-parav@nvidia.com>
From: David Hildenbrand <david@redhat.com>
In-Reply-To: <20230112212254.763783-1-parav@nvidia.com>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: Parav Pandit <parav@nvidia.com>, mst@redhat.com, virtio-dev@lists.oasis-open.org, cohuck@redhat.com
Cc: virtio-comment@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

On 12.01.23 22:22, Parav Pandit wrote:
> Relatively several of the recent device specifications are maintained
> in their own specification file. Such separate files enables better
> maintenance of the specification overall.
> However, several of the initial virtio device specifications
> are located in single file.
> 
> Hence, split them into their individual files.
> 
> Additionally, each device's driver and device conformance is
> present in one giant conformance file all together.
> 
> As Michael suggest's move this device and driver conformance
> section adjacent to device specification in each device specific
> directory. This further makes device specification self-contained.
> 

Yeah, that looks much cleaner now, thanks!

-- 
Thanks,

David / dhildenb

