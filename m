Return-Path: <eperezma@redhat.com>
MIME-Version: 1.0
References: <20210706043334.36359-1-jasowang@redhat.com> <20210706043334.36359-3-jasowang@redhat.com>
 <YOQhW9MUlv5ohe05@work-vm> <52e1347c-9363-8ff8-e36c-2681b42e4c37@redhat.com>
In-Reply-To: <52e1347c-9363-8ff8-e36c-2681b42e4c37@redhat.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Fri, 9 Jul 2021 19:23:33 +0200
Message-ID: <CAJaqyWeQQZopTWDxnG3yUyS9qyGSXYTj3KwuhFqbzKih3te6AQ@mail.gmail.com>
Subject: Re: [virtio-comment] [PATCH V2 2/2] virtio: introduce STOP status bit
Content-Type: text/plain; charset="UTF-8"
To: Jason Wang <jasowang@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Michael Tsirkin <mst@redhat.com>, virtio-comment@lists.oasis-open.org, Virtio-Dev <virtio-dev@lists.oasis-open.org>, Stefan Hajnoczi <stefanha@redhat.com>, Max Gurtovoy <mgurtovoy@nvidia.com>, Cornelia Huck <cohuck@redhat.com>, Oren Duer <oren@nvidia.com>, Shahaf Shuler <shahafs@nvidia.com>, Parav Pandit <parav@nvidia.com>, Bodong Wang <bodong@nvidia.com>, Alexander Mikheev <amikheev@nvidia.com>, Halil Pasic <pasic@linux.ibm.com>
List-ID: <virtio-dev.lists.oasis-open.org>

> >   If I understand correctly, this is all
> > driven from the driver inside the guest, so for this to work
> > the guest must be running and already have initialised the driver.
>
>
> Yes.
>

As I see it, the feature can be driven entirely by the VMM as long as
it intercept the relevant configuration space (PCI, MMIO, etc) from
guest's reads and writes, and present it as coherent and transparent
for the guest. Some use cases I can imagine with a physical device (or
vp_vpda device) with VIRTIO_F_STOP:

1) The VMM chooses not to pass the feature flag. The guest cannot stop
the device, so any write to this flag is an error/undefined.
2) The VMM passes the flag to the guest. The guest can stop the device.
2.1) The VMM stops the device to perform a live migration, and the
guest does not write to STOP in any moment of the LM. It resets the
destination device with the state, and then initializes the device.
2.2) The guest stops the device and, when STOP(32) is set, the source
VMM migrates the device status. The destination VMM realizes the bit,
so it sets the bit in the destination too after device initialization.
2.3) The device is not initialized by the guest so it doesn't matter
what bit has the HW, but the VM can be migrated.

Am I missing something?

Thanks!

