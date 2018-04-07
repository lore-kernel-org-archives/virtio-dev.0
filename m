Return-Path: virtio-dev-return-3746-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 2E1E058191BE
	for <virtio-dev@lists.oasis-open.org>; Fri,  6 Apr 2018 19:54:35 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <d666b8a9-9ff8-4a56-0faa-ef3d0bf81d25@redhat.com>
References: <1522573990-5242-1-git-send-email-si-wei.liu@oracle.com>
 <1522573990-5242-2-git-send-email-si-wei.liu@oracle.com> <20180403152308-mutt-send-email-mst@kernel.org>
 <CADGSJ23jr7xrq8h9rFHLtXkbpsB+AK8wcUzOQnpeftbhiYdOvA@mail.gmail.com> <d666b8a9-9ff8-4a56-0faa-ef3d0bf81d25@redhat.com>
From: Siwei Liu <loseweigh@gmail.com>
Date: Fri, 6 Apr 2018 19:54:33 -0700
Message-ID: <CADGSJ22Zqm1s2Xr=i4G7upp4mZRHz4HEQGVvzNjBTcdCQ4hoDw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [virtio-dev] Re: [RFC PATCH 1/3] qemu: virtio-bypass should
 explicitly bind to a passthrough device
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Si-Wei Liu <si-wei.liu@oracle.com>, Jiri Pirko <jiri@resnulli.us>, Stephen Hemminger <stephen@networkplumber.org>, Alexander Duyck <alexander.h.duyck@intel.com>, David Miller <davem@davemloft.net>, "Brandeburg, Jesse" <jesse.brandeburg@intel.com>, Jakub Kicinski <kubakici@wp.pl>, Jason Wang <jasowang@redhat.com>, "Samudrala, Sridhar" <sridhar.samudrala@intel.com>, Netdev <netdev@vger.kernel.org>, virtualization@lists.linux-foundation.org, virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

(click the wrong reply button again, sorry)


On Thu, Apr 5, 2018 at 8:31 AM, Paolo Bonzini <pbonzini@redhat.com> wrote:
> On 04/04/2018 10:02, Siwei Liu wrote:
>>> pci_bus_num is almost always a bug if not done within
>>> a context of a PCI host, bridge, etc.
>>>
>>> In particular this will not DTRT if run before guest assigns bus
>>> numbers.
>>>
>> I was seeking means to reserve a specific pci bus slot from drivers,
>> and update the driver when guest assigns the bus number but it seems
>> there's no low-hanging fruits. Because of that reason the bus_num is
>> only obtained until it's really needed (during get_config) and I
>> assume at that point the pci bus assignment is already done. I know
>> the current one is not perfect, but we need that information (PCI
>> bus:slot.func number) to name the guest device correctly.
>
> Can you use the -device "id", and look it up as
>
>     devices = container_get(qdev_get_machine(), "/peripheral");
>     return object_resolve_path_component(devices, id);


No. The problem of using device id is that the vfio device may come
and go at any time, this is particularly true when live migration is
happening. There's no gurantee we can get the bus:device.func info if
that device is gone. Currently the binding between vfio and virtio-net
is weakly coupled through the backup property, there's no better way
than specifying the bus id and addr property directly.

Regards,
-Siwei

>
> ?
>
> Thanks,
>
> Paolo

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

