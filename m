Return-Path: virtio-dev-return-4037-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 714F51CB807B
	for <virtio-dev@lists.oasis-open.org>; Wed,  2 May 2018 23:46:48 -0700 (PDT)
References: <CAMYfGhDVst56pCL2H3VsxPvkeu76POPvhkEH0VgjnpL0eVyJ9A@mail.gmail.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <f3d8eed7-13d1-78d0-5eef-e79acb543921@redhat.com>
Date: Thu, 3 May 2018 08:46:36 +0200
MIME-Version: 1.0
In-Reply-To: <CAMYfGhDVst56pCL2H3VsxPvkeu76POPvhkEH0VgjnpL0eVyJ9A@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [virtio-dev] Slow access using virtio : Ramblock device
To: Radhesh Krishnan K <radheshkrishnank@gmail.com>, virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

On 02.05.2018 21:42, Radhesh Krishnan K wrote:
> Hi Everyone,
> 
> 
> I am attaching a ramblock device to the guest machine as a 
> normal block device and trying to write from the guest machine 
> to host's ramblock device. Block device is attached using Virtio 
> using following command:
> 
> ``` qemu-system-x86_64 -enable-kvm  -machine type=pc,accel=kvm -cpu host
> smp 1 -nographic  -k de  -m 1024  ubuntu16.04.qcow2  -drive
> if=none,id=drive0,file=/dev/ram -device  virtio-blk
> pci,physical_block_size=4096,logical_block_size=4096,drive=drive0```
> 
> Looks like these writes from Guest to host's RAM using Virtio is very slow 
> (slow like writing to a SSD).  What could be the reason for that?  Does a 
> write  on a virtualized blkdev will result in a VMEXIT? If not, does it
> will be 

Hi,

Accesses to virtio-blk devices are always intercepted and processed by
QEMU (due to the virtio queue nature of these devices).

You might instead want to consider using an NVDIMM. There, the file is
directly mapped into guest physical address space and the guest can R/W
to it without intercepting to QEMU.


> "zero-copy"?  What am I missing here? Any pointers on this is greatly
> appreciated.
> Thanks in advance.
> 
> 
> 
>  
> Regards,
> Radhesh Krishnan K.


-- 

Thanks,

David / dhildenb

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

