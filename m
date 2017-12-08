Return-Path: virtio-dev-return-2791-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id D4FA45818038
	for <virtio-dev@lists.oasis-open.org>; Fri,  8 Dec 2017 06:27:42 -0800 (PST)
Date: Fri, 8 Dec 2017 16:27:33 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20171208161606-mutt-send-email-mst@kernel.org>
References: <5A290398.60508@intel.com>
 <CAJSP0QURjdD8BnOmJo83fzJn_zCijSKQh==Pz+Xu4r6Q2i3SkQ@mail.gmail.com>
 <20171207153454-mutt-send-email-mst@kernel.org>
 <CAJSP0QVu4iwAu01Sth84VZshQde97x3FW1E1ua_YXVKs-65vhQ@mail.gmail.com>
 <20171207183945-mutt-send-email-mst@kernel.org>
 <CAJSP0QVnukGD3Afu9myv=v5OjqrPDpXu6JL3Tpf+Cdk=em9V3w@mail.gmail.com>
 <20171207193003-mutt-send-email-mst@kernel.org>
 <CAJSP0QX4V64OoU4-Dhb93MUZ9Rz0FPR-La5Xq4_yqGH7SG6PjQ@mail.gmail.com>
 <20171207213420-mutt-send-email-mst@kernel.org>
 <CAJSP0QXYMVBidUd5-NJb5FDYbc6wSkNYgdadjk8+NXvwosLMPw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJSP0QXYMVBidUd5-NJb5FDYbc6wSkNYgdadjk8+NXvwosLMPw@mail.gmail.com>
Subject: [virtio-dev] Re: [Qemu-devel] [virtio-dev] [PATCH v3 0/7] Vhost-pci for inter-VM
 communication
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: Wei Wang <wei.w.wang@intel.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "Yang, Zhiyong" <zhiyong.yang@intel.com>, "jan.kiszka@siemens.com" <jan.kiszka@siemens.com>, "jasowang@redhat.com" <jasowang@redhat.com>, "avi.cohen@huawei.com" <avi.cohen@huawei.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "marcandre.lureau@redhat.com" <marcandre.lureau@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Fri, Dec 08, 2017 at 06:08:05AM +0000, Stefan Hajnoczi wrote:
> On Thu, Dec 7, 2017 at 11:54 PM, Michael S. Tsirkin <mst@redhat.com> wrote:
> > On Thu, Dec 07, 2017 at 06:28:19PM +0000, Stefan Hajnoczi wrote:
> >> On Thu, Dec 7, 2017 at 5:38 PM, Michael S. Tsirkin <mst@redhat.com> wrote:
> >> > On Thu, Dec 07, 2017 at 05:29:14PM +0000, Stefan Hajnoczi wrote:
> >> >> On Thu, Dec 7, 2017 at 4:47 PM, Michael S. Tsirkin <mst@redhat.com> wrote:
> >> >> > On Thu, Dec 07, 2017 at 04:29:45PM +0000, Stefan Hajnoczi wrote:
> >> >> >> On Thu, Dec 7, 2017 at 2:02 PM, Michael S. Tsirkin <mst@redhat.com> wrote:
> >> >> >> > On Thu, Dec 07, 2017 at 01:08:04PM +0000, Stefan Hajnoczi wrote:
> >> >> >> >> Instead of responding individually to these points, I hope this will
> >> >> >> >> explain my perspective.  Let me know if you do want individual
> >> >> >> >> responses, I'm happy to talk more about the points above but I think
> >> >> >> >> the biggest difference is our perspective on this:
> >> >> >> >>
> >> >> >> >> Existing vhost-user slave code should be able to run on top of
> >> >> >> >> vhost-pci.  For example, QEMU's
> >> >> >> >> contrib/vhost-user-scsi/vhost-user-scsi.c should work inside the guest
> >> >> >> >> with only minimal changes to the source file (i.e. today it explicitly
> >> >> >> >> opens a UNIX domain socket and that should be done by libvhost-user
> >> >> >> >> instead).  It shouldn't be hard to add vhost-pci vfio support to
> >> >> >> >> contrib/libvhost-user/ alongside the existing UNIX domain socket code.
> >> >> >> >>
> >> >> >> >> This seems pretty easy to achieve with the vhost-pci PCI adapter that
> >> >> >> >> I've described but I'm not sure how to implement libvhost-user on top
> >> >> >> >> of vhost-pci vfio if the device doesn't expose the vhost-user
> >> >> >> >> protocol.
> >> >> >> >>
> >> >> >> >> I think this is a really important goal.  Let's use a single
> >> >> >> >> vhost-user software stack instead of creating a separate one for guest
> >> >> >> >> code only.
> >> >> >> >>
> >> >> >> >> Do you agree that the vhost-user software stack should be shared
> >> >> >> >> between host userspace and guest code as much as possible?
> >> >> >> >
> >> >> >> >
> >> >> >> >
> >> >> >> > The sharing you propose is not necessarily practical because the security goals
> >> >> >> > of the two are different.
> >> >> >> >
> >> >> >> > It seems that the best motivation presentation is still the original rfc
> >> >> >> >
> >> >> >> > http://virtualization.linux-foundation.narkive.com/A7FkzAgp/rfc-vhost-user-enhancements-for-vm2vm-communication
> >> >> >> >
> >> >> >> > So comparing with vhost-user iotlb handling is different:
> >> >> >> >
> >> >> >> > With vhost-user guest trusts the vhost-user backend on the host.
> >> >> >> >
> >> >> >> > With vhost-pci we can strive to limit the trust to qemu only.
> >> >> >> > The switch running within a VM does not have to be trusted.
> >> >> >>
> >> >> >> Can you give a concrete example?
> >> >> >>
> >> >> >> I have an idea about what you're saying but it may be wrong:
> >> >> >>
> >> >> >> Today the iotlb mechanism in vhost-user does not actually enforce
> >> >> >> memory permissions.  The vhost-user slave has full access to mmapped
> >> >> >> memory regions even when iotlb is enabled.  Currently the iotlb just
> >> >> >> adds an indirection layer but no real security.  (Is this correct?)
> >> >> >
> >> >> > Not exactly. iotlb protects against malicious drivers within guest.
> >> >> > But yes, not against a vhost-user driver on the host.
> >> >> >
> >> >> >> Are you saying the vhost-pci device code in QEMU should enforce iotlb
> >> >> >> permissions so the vhost-user slave guest only has access to memory
> >> >> >> regions that are allowed by the iotlb?
> >> >> >
> >> >> > Yes.
> >> >>
> >> >> Okay, thanks for confirming.
> >> >>
> >> >> This can be supported by the approach I've described.  The vhost-pci
> >> >> QEMU code has control over the BAR memory so it can prevent the guest
> >> >> from accessing regions that are not allowed by the iotlb.
> >> >>
> >> >> Inside the guest the vhost-user slave still has the memory region
> >> >> descriptions and sends iotlb messages.  This is completely compatible
> >> >> with the libvirt-user APIs and existing vhost-user slave code can run
> >> >> fine.  The only unique thing is that guest accesses to memory regions
> >> >> not allowed by the iotlb do not work because QEMU has prevented it.
> >> >
> >> > I don't think this can work since suddenly you need
> >> > to map full IOMMU address space into BAR.
> >>
> >> The BAR covers all guest RAM
> >> but QEMU can set up MemoryRegions that
> >> hide parts from the guest (e.g. reads produce 0xff).  I'm not sure how
> >> expensive that is but implementing a strict IOMMU is hard to do
> >> without performance overhead.
> >
> > I'm worried about leaking PAs.
> > fundamentally if you want proper protection you
> > need your device driver to use VA for addressing,
> >
> > On the one hand BAR only needs to be as large as guest PA then.
> > On the other hand it must cover all of guest PA,
> > not just what is accessible to the device.
> 
> A more heavyweight iotlb implementation in QEMU's vhost-pci device
> could present only VAs to the vhost-pci driver.  It would use
> MemoryRegions to map pieces of shared guest memory dynamically.  The
> only information leak would be the overall guest RAM size because we
> still need to set the correct BAR size.

I'm not sure this will work. KVM simply
isn't designed with a huge number of fragmented regions
in mind.

Wei, just what is the plan for the IOMMU? How will
all virtual addresses fit in a BAR?

Maybe we really do want a non-translating IOMMU
(leaking PA to userspace but oh well)?

> >>
> >> > Besides, this means implementing iotlb in both qemu and guest.
> >>
> >> It's free in the guest, the libvhost-user stack already has it.
> >
> > That library is designed to work with a unix domain socket
> > though. We'll need extra kernel code to make a device
> > pretend it's a socket.
> 
> A kernel vhost-pci driver isn't necessary because I don't think there
> are in-kernel users.
>
> A vfio vhost-pci backend can go alongside the UNIX domain socket
> backend that exists today in libvhost-user.
> 
> If we want to expose kernel vhost devices via vhost-pci then a
> libvhost-user program can translate the vhost-user protocol into
> kernel ioctls.  For example:
> $ vhost-pci-proxy --vhost-pci-addr 00:04.0 --vhost-fd 3 3<>/dev/vhost-net
> 
> The vhost-pci-proxy implements the vhost-user protocol callbacks and
> submits ioctls on the vhost kernel device fd.  I haven't compared the
> kernel ioctl interface vs the vhost-user protocol to see if everything
> maps cleanly though.
> 
> Stefan

I don't really like this, it's yet another package to install, yet
another process to complicate debugging and yet another service that can
go down.

Maybe vsock can do the trick though?

-- 
MST

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

