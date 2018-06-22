Return-Path: virtio-dev-return-4485-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 3631B581810D
	for <virtio-dev@lists.oasis-open.org>; Fri, 22 Jun 2018 12:43:29 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180622052717-mutt-send-email-mst@kernel.org>
References: <1525734594-11134-1-git-send-email-sridhar.samudrala@intel.com>
 <fcefe501-b410-f1ec-829c-68199edcdbef@intel.com> <20180605152344-mutt-send-email-mst@kernel.org>
 <a45625c9-d2cd-f8f7-ce31-37c558e70b88@redhat.com> <20180612144743-mutt-send-email-mst@kernel.org>
 <5718de66-74c9-1362-a87b-2eba02475b48@redhat.com> <c29a5ac9-cfb5-0a19-f28c-30d41bd5efcf@intel.com>
 <ce4da2b0-88fd-c79b-0567-fe564bb34922@redhat.com> <20180621211359-mutt-send-email-mst@kernel.org>
 <CADGSJ216itm89dUuK_vOfuBsBq5bq4485GqMKjB1JXFD_PLZxA@mail.gmail.com> <20180622052717-mutt-send-email-mst@kernel.org>
From: Siwei Liu <loseweigh@gmail.com>
Date: Fri, 22 Jun 2018 12:43:26 -0700
Message-ID: <CADGSJ210d358_uyNK9LLw9gpP5uXK6T0h=9mR9ryG7ySkVqvkA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [virtio-dev] Re: [PATCH] qemu: Introduce VIRTIO_NET_F_STANDBY
 feature bit to virtio_net
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>, "Samudrala, Sridhar" <sridhar.samudrala@intel.com>, virtualization@lists.linux-foundation.org, virtio-dev@lists.oasis-open.org, "Brandeburg, Jesse" <jesse.brandeburg@intel.com>, Alexander Duyck <alexander.h.duyck@intel.com>, qemu-devel@nongnu.org
List-ID: <virtio-dev.lists.oasis-open.org>

On Thu, Jun 21, 2018 at 7:30 PM, Michael S. Tsirkin <mst@redhat.com> wrote:
> On Thu, Jun 21, 2018 at 06:07:18PM -0700, Siwei Liu wrote:
>> On Thu, Jun 21, 2018 at 11:14 AM, Michael S. Tsirkin <mst@redhat.com> wr=
ote:
>> > On Wed, Jun 13, 2018 at 01:40:59PM +0800, Jason Wang wrote:
>> >>
>> >>
>> >> On 2018=E5=B9=B406=E6=9C=8813=E6=97=A5 12:24, Samudrala, Sridhar wrot=
e:
>> >> > On 6/12/2018 7:38 PM, Jason Wang wrote:
>> >> > >
>> >> > >
>> >> > > On 2018=E5=B9=B406=E6=9C=8812=E6=97=A5 19:54, Michael S. Tsirkin =
wrote:
>> >> > > > On Wed, Jun 06, 2018 at 10:29:03AM +0800, Jason Wang wrote:
>> >> > > > >
>> >> > > > > On 2018=E5=B9=B406=E6=9C=8805=E6=97=A5 20:33, Michael S. Tsir=
kin wrote:
>> >> > > > > > I don't think this is sufficient.
>> >> > > > > >
>> >> > > > > > If both primary and standby devices are present, a
>> >> > > > > > legacy guest without
>> >> > > > > > support for the feature might see two devices with same mac=
 and get
>> >> > > > > > confused.
>> >> > > > > >
>> >> > > > > > I think that we should only make primary visible after
>> >> > > > > > guest acked the
>> >> > > > > > backup feature bit.
>> >> > > > > I think we want exactly the reverse? E.g fail the
>> >> > > > > negotiation when guest
>> >> > > > > does not ack backup feature.
>> >> > > > >
>> >> > > > > Otherwise legacy guest won't even have the chance to see
>> >> > > > > primary device in
>> >> > > > > the guest.
>> >> > > > That's by design.
>> >> > >
>> >> > > So management needs to know the capability of guest to set the
>> >> > > backup feature. This looks a chicken or egg problem to me.
>> >> >
>> >> > I don't think so. If the tenant requests 'accelerated datapath feat=
ure',
>> >> > the management
>> >> > will set 'standby' feature bit on virtio-net interface and if the g=
uest
>> >> > virtio-net driver
>> >> > supports this feature, then the tenant VM will get that capability =
via a
>> >> > hot-plugged
>> >> > primary device.
>> >>
>> >> Ok, I thought exactly the reverse because of the commit title is "ena=
ble
>> >> virtio_net to act as a standby for a passthru device". But re-read th=
e
>> >> commit log content, I understand the case a little bit. Btw, VF is no=
t
>> >> necessarily faster than virtio-net, especially consider virtio-net ma=
y have
>> >> a lot of queues.
>> >
>> > Don't do that then, right?
>>
>> I don't understand. Where did the standby feature come to imply the
>> "accelerated datapath" thing?
>> Isn't failover/standby a generic high
>> availblity term, rather than marry it to the concept of device model
>> specifics? Do we expect scsi to work exactly the same way with
>> "accelerated datapath"?
>
> That's not what I said.
> The semantics are that the primary is always used if present in
> preference to standby.
OK. If this is the only semantics of what "standby" refers to in
general, that is fine.

I just don't want to limit the failover/standby semantics to the
device model specifics, the "accelerated datapath" thing or whatever.
I really don't know where the requirements of the "accelerated
datapath" came from, as the originial problem is migrating vfio
devices which is in match of QEMU's live migration model. Hyper-V has
it's limitation to do 1-netdev should not impact how KVM/QEMU should
be doing it.

> Jason said virtio net is sometimes preferable.
> If that's the case don't make it a standby.
>
> More advanced use-cases do exist and e.g. Alexander Duyck
> suggested using a switch-dev.

The switchdev case would need a new feature bit, right?

-Siwei

> failover isn't it though.
>
> --
> MST

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

