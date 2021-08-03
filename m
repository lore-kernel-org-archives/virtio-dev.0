Return-Path: <david@redhat.com>
Subject: Re: [PATCH RESEND] virtio-pmem: PMEM device spec
References: <20210728150435.264551-1-pankaj.gupta.linux@gmail.com>
 <87r1fg10hm.fsf@redhat.com>
 <CAM9Jb+jAbBrsQbR8hHFcskqXojj47kMc0xzivQMH0Ax2uUb8ng@mail.gmail.com>
 <87mtpzylvl.fsf@redhat.com>
 <CAM9Jb+jjRE0q+kU6FgxoTxmXM_tUQQJcA4Kvg3Ra+UmHz7ym4g@mail.gmail.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <68a1ff16-1f7a-1ecb-6d05-7521d2397453@redhat.com>
Date: Tue, 3 Aug 2021 11:17:59 +0200
MIME-Version: 1.0
In-Reply-To: <CAM9Jb+jjRE0q+kU6FgxoTxmXM_tUQQJcA4Kvg3Ra+UmHz7ym4g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: Pankaj Gupta <pankaj.gupta.linux@gmail.com>, Cornelia Huck <cohuck@redhat.com>
Cc: virtio-dev@lists.oasis-open.org, Dan Williams <dan.j.williams@intel.com>, "Michael S . Tsirkin" <mst@redhat.com>, Taylor Stark <tstark@linux.microsoft.com>, Pankaj Gupta <pankaj.gupta@ionos.com>
List-ID: <virtio-dev.lists.oasis-open.org>

>>> Driver SHOULD handle multiple FLUSH requests on the files present on
>>> the Virtio pmem device.
>>
>> Same here. I'm afraid this is not easy :(
> 
> hmm...
> 
> The driver SHOULD handle multiple FLUSH requests.

Do you want to say

The driver MUST be able to handle concurrent FLUSH requests.

?

-- 
Thanks,

David / dhildenb

