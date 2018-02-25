Return-Path: virtio-dev-return-3274-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id E7DA85819119
	for <virtio-dev@lists.oasis-open.org>; Sun, 25 Feb 2018 14:21:15 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180223155904.27b11865@xeon-e3>
References: <20180220201410.GF2031@nanopsycho> <20180220143356.3467084d@cakuba.netronome.com>
 <20180221095159.GA1996@nanopsycho> <CAKgT0UdyhrVr=pYZb=AJq9sWWUVb_BadbJTcqY1AwHHTw8cmQw@mail.gmail.com>
 <20180221161105.GC1996@nanopsycho> <CAKgT0Ud+6eiY7ycyju1SToeatH1R7KBDcUOqjn9Pu2k5uOr5Wg@mail.gmail.com>
 <20180221165848.GD1996@nanopsycho> <CAKgT0UeZS_SzNfiMX3ujy+a9WZWySVdyTpyQ=b=RJJrAG3JO=w@mail.gmail.com>
 <20180221193832.GE1996@nanopsycho> <CAKgT0Ud--R7Mw1_jFckskhGmGLZgZbTZ24TuvJ+UWvm_MAQR9w@mail.gmail.com>
 <20180222081115.GC1994@nanopsycho> <CAKgT0UeVhPOgRM0J6fyGDAJrTnqjc6AtC8+_UMs=hojZAajtdg@mail.gmail.com>
 <20180223155904.27b11865@xeon-e3>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Sun, 25 Feb 2018 14:21:13 -0800
Message-ID: <CAKgT0UcP3DUyN9bkcpd5NN6wW_fN4Su9gCt4hGdwTd3AJZkwhg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [virtio-dev] Re: [RFC PATCH v3 0/3] Enable virtio_net to act as a backup for a
 passthru device
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: Jiri Pirko <jiri@resnulli.us>, Jakub Kicinski <kubakici@wp.pl>, "Samudrala, Sridhar" <sridhar.samudrala@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>, David Miller <davem@davemloft.net>, Netdev <netdev@vger.kernel.org>, virtualization@lists.linux-foundation.org, virtio-dev@lists.oasis-open.org, "Brandeburg, Jesse" <jesse.brandeburg@intel.com>, "Duyck, Alexander H" <alexander.h.duyck@intel.com>, Jason Wang <jasowang@redhat.com>, Siwei Liu <loseweigh@gmail.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Fri, Feb 23, 2018 at 3:59 PM, Stephen Hemminger
<stephen@networkplumber.org> wrote:
> On Thu, 22 Feb 2018 13:30:12 -0800
> Alexander Duyck <alexander.duyck@gmail.com> wrote:
>
>> > Again, I undertand your motivation. Yet I don't like your solution.
>> > But if the decision is made to do this in-driver bonding. I would like
>> > to see it baing done some generic way:
>> > 1) share the same "in-driver bonding core" code with netvsc
>> >    put to net/core.
>> > 2) the "in-driver bonding core" will strictly limit the functionality,
>> >    like active-backup mode only, one vf, one backup, vf netdev type
>> >    check (so noone could enslave a tap or anything else)
>> > If user would need something more, he should employ team/bond.
>
> Sharing would be good, but netvsc world would really like to only have
> one visible network device.

Other than the netdev count are there any other issues we need to be
thinking about?

If I am not mistaken you netvsc doesn't put any broadcast/multicast
filters on the VF. If we ended up doing that in order to support the
virtio based solution would that cause any issues? I just realized we
had overlooked dealing with multicast in our current solution so we
will probably be looking at syncing the multicast list like what
occurs in netvsc, however we will need to do it for both the VF and
the virtio interfaces.

Thanks.

- Alex

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

