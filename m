Return-Path: <mst@redhat.com>
Date: Sat, 10 Jul 2021 16:36:31 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [virtio-comment] [PATCH V2 2/2] virtio: introduce STOP status bit
Message-ID: <20210710163326-mutt-send-email-mst@kernel.org>
References: <20210706043334.36359-1-jasowang@redhat.com>
 <20210706043334.36359-3-jasowang@redhat.com>
 <YOQhW9MUlv5ohe05@work-vm>
 <52e1347c-9363-8ff8-e36c-2681b42e4c37@redhat.com>
 <CAJaqyWeQQZopTWDxnG3yUyS9qyGSXYTj3KwuhFqbzKih3te6AQ@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAJaqyWeQQZopTWDxnG3yUyS9qyGSXYTj3KwuhFqbzKih3te6AQ@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: Eugenio Perez Martin <eperezma@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, virtio-comment@lists.oasis-open.org, Virtio-Dev <virtio-dev@lists.oasis-open.org>, Stefan Hajnoczi <stefanha@redhat.com>, Max Gurtovoy <mgurtovoy@nvidia.com>, Cornelia Huck <cohuck@redhat.com>, Oren Duer <oren@nvidia.com>, Shahaf Shuler <shahafs@nvidia.com>, Parav Pandit <parav@nvidia.com>, Bodong Wang <bodong@nvidia.com>, Alexander Mikheev <amikheev@nvidia.com>, Halil Pasic <pasic@linux.ibm.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Fri, Jul 09, 2021 at 07:23:33PM +0200, Eugenio Perez Martin wrote:
> > >   If I understand correctly, this is all
> > > driven from the driver inside the guest, so for this to work
> > > the guest must be running and already have initialised the driver.
> >
> >
> > Yes.
> >
> 
> As I see it, the feature can be driven entirely by the VMM as long as
> it intercept the relevant configuration space (PCI, MMIO, etc) from
> guest's reads and writes, and present it as coherent and transparent
> for the guest. Some use cases I can imagine with a physical device (or
> vp_vpda device) with VIRTIO_F_STOP:
> 
> 1) The VMM chooses not to pass the feature flag. The guest cannot stop
> the device, so any write to this flag is an error/undefined.
> 2) The VMM passes the flag to the guest. The guest can stop the device.
> 2.1) The VMM stops the device to perform a live migration, and the
> guest does not write to STOP in any moment of the LM. It resets the
> destination device with the state, and then initializes the device.
> 2.2) The guest stops the device and, when STOP(32) is set, the source
> VMM migrates the device status. The destination VMM realizes the bit,
> so it sets the bit in the destination too after device initialization.
> 2.3) The device is not initialized by the guest so it doesn't matter
> what bit has the HW, but the VM can be migrated.
> 
> Am I missing something?
> 
> Thanks!

It's doable like this. It's all a lot of hoops to jump through though.
It's also not easy for devices to implement.
Why don't we design the feature in a way that is useable by VMMs
and implementable by devices in a simple way?

-- 
MST

