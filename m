Return-Path: virtio-dev-return-4866-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 78CE4985D8C
	for <virtio-dev@lists.oasis-open.org>; Thu, 20 Sep 2018 03:04:21 +0000 (UTC)
Date: Wed, 19 Sep 2018 23:04:17 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180919225843-mutt-send-email-mst@kernel.org>
References: <1534358955-35869-1-git-send-email-sridhar.samudrala@intel.com>
 <20180907173251-mutt-send-email-mst@kernel.org>
 <9bc2db49-77ea-1391-b964-a29da44ff617@intel.com>
 <20180912111819-mutt-send-email-mst@kernel.org>
 <20180918122052.349ba42e.cohuck@redhat.com>
 <CAKPgXcGpQt1OSOHnXxTfo0j4H5z+TPZSgRkz2BsiT3+Qo_7AwQ@mail.gmail.com>
 <20180918091231-mutt-send-email-mst@kernel.org>
 <CADGSJ23LusA=HcxaAjGxGvfwB9FOfUmkm2gnadzWydu0usnYiw@mail.gmail.com>
 <20180918143853-mutt-send-email-mst@kernel.org>
 <CADGSJ20uDDWXt4FXYEUyCcFixTjCDmPVjEAxLJdH-urHmzEhOQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADGSJ20uDDWXt4FXYEUyCcFixTjCDmPVjEAxLJdH-urHmzEhOQ@mail.gmail.com>
Subject: Re: [virtio-dev] [PATCH v4] content: Introduce VIRTIO_NET_F_STANDBY
 feature
To: Siwei Liu <loseweigh@gmail.com>
Cc: Sameeh Jubran <sameeh@daynix.com>, Cornelia Huck <cohuck@redhat.com>, "Samudrala, Sridhar" <sridhar.samudrala@intel.com>, virtio-dev <virtio-dev@lists.oasis-open.org>
List-ID: <virtio-dev.lists.oasis-open.org>

On Tue, Sep 18, 2018 at 12:10:54PM -0700, Siwei Liu wrote:
> On Tue, Sep 18, 2018 at 11:39 AM, Michael S. Tsirkin <mst@redhat.com> wrote:
> > On Tue, Sep 18, 2018 at 11:30:27AM -0700, Siwei Liu wrote:
> >> On Tue, Sep 18, 2018 at 6:25 AM, Michael S. Tsirkin <mst@redhat.com> wrote:
> >> > On Tue, Sep 18, 2018 at 01:37:35PM +0300, Sameeh Jubran wrote:
> >> >> On Tue, Sep 18, 2018 at 1:21 PM Cornelia Huck <cohuck@redhat.com> wrote:
> >> >> >
> >> >> > On Wed, 12 Sep 2018 11:22:12 -0400
> >> >> > "Michael S. Tsirkin" <mst@redhat.com> wrote:
> >> >> >
> >> >> > > On Wed, Sep 12, 2018 at 08:17:45AM -0700, Samudrala, Sridhar wrote:
> >> >> > > >
> >> >> > > >
> >> >> > > > On 9/7/2018 2:34 PM, Michael S. Tsirkin wrote:
> >> >> > > > > On Wed, Aug 15, 2018 at 11:49:15AM -0700, Sridhar Samudrala wrote:
> >> >> > > > > > VIRTIO_NET_F_STANDBY feature enables hypervisor to indicate virtio_net
> >> >> > > > > > device to act as a standby for another device with the same MAC address.
> >> >> > > > > >
> >> >> > > > > > Signed-off-by: Sridhar Samudrala <sridhar.samudrala@intel.com>
> >> >> > > > > > Acked-by: Cornelia Huck <cohuck@redhat.com>
> >> >> > > > > > Fixes: https://github.com/oasis-tcs/virtio-spec/issues/18
> >> >> > > > > Applied but when do you plan to add documentation as pointed
> >> >> > > > > out by Jan and Halil?
> >> >> > > >
> >> >> > > > I thought additional documentation will be done as part of the Qemu enablement
> >> >> > > > patches and i hope someone in RH is looking into it.
> >> >> > > >
> >> >> > > > Does it make sense to add a link to to the kernel documentation of this feature in
> >> >> > > > the spec
> >> >> > > >  https://www.kernel.org/doc/html/latest/networking/net_failover.html
> >> >> > >
> >> >> > >
> >> >> > > I do not think this will address the comments posted.  Specifically we
> >> >> > > should probably include documentation for what is a standby and primary:
> >> >> > > what is expected of driver (maintain configuration on standby, support
> >> >> > > primary coming and going, transmit on standby only if there is no
> >> >> > > primary) and of device (have same mac for standby as for standby).
> >> >> >
> >> >> > Yes, we need some definitive statements of what a driver and a device
> >> >> > is supposed to do in order to conform; it might make sense to discuss
> >> >> > this in conjunction with discussion on any QEMU patches (have not
> >> >> > checked whether anything has been posted, just returned from vacation).
> >> >> >
> >> >> > I assume that we still stick with the plan to implement/document
> >> >> > MAC-based handling first and then enhance with other methods later?
> >> >>
> >> >> I am currently in the process of writing the patches for this feature,
> >> >> I have thought about how the feature should be implemented
> >> >> and decided to go with a different approach. I've decided that the id
> >> >> of the vfio attached device will be specified in the virtio-net
> >> >> arguments as follows:
> >> >>
> >> >> -device virtio-net,standby=<device_id_of_vfio_device>
> >> >> -vfio #address,id=<device_id_of_vfio_device>
> >> >>
> >> >> This approach makes minimal changes to the current infrastructure and
> >> >> does so elegantly without adding unnecessary ids to the bridges.
> >> >>
> >> >> The mac address approach seems to be very complicated as there is no
> >> >> standard way to find the mac address of a given device and it is
> >> >> vendor dependent,
> >> >> which makes the task of identifying the target standby device by it's
> >> >> mac address a very tough one.
> >> >
> >> > Oh mac address is used by guest. I agree it's not a great qemu
> >> > interface.
> >> > The idea was basically to have -vfio #address,primary=<id>
> >>
> >> Interesting... How do you make sure the MAC address are same (grouped)
> >> between vfio and virtio-net-pci (from QEMU side)? I thought the spec
> >> meant to make this a guest-host interface, right?
> >>
> >> -Siwei
> >
> > I guess at this point that can be up to the management tool.
> 
> Although still a guest-host interface, moving this device-driver
> virtio requirement to management toolstack is poor engineering
> practice IMO.
> 
> -Siwei

There are advantages to doing it outside QEMU, such as
security (libvirt has access to netlink, QEMU doesn't).
It doesn't look like such an important detail  to me -
these details are going to be up to whoever implements it.

Anyway we are discussing this on a wrong list. Where does code belong
(qemu or libvirt) is a question to be discussed on qemu
and libvirt lists, virtio spec does not care which
host side module does what.



---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

