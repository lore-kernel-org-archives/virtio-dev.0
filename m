Return-Path: virtio-dev-return-3263-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id E51675818123
	for <virtio-dev@lists.oasis-open.org>; Thu, 22 Feb 2018 07:30:50 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180222130717.GE1994@nanopsycho>
References: <20180221095159.GA1996@nanopsycho> <CAKgT0UdyhrVr=pYZb=AJq9sWWUVb_BadbJTcqY1AwHHTw8cmQw@mail.gmail.com>
 <20180221161105.GC1996@nanopsycho> <CAKgT0Ud+6eiY7ycyju1SToeatH1R7KBDcUOqjn9Pu2k5uOr5Wg@mail.gmail.com>
 <20180221165848.GD1996@nanopsycho> <CAKgT0UeZS_SzNfiMX3ujy+a9WZWySVdyTpyQ=b=RJJrAG3JO=w@mail.gmail.com>
 <20180221193832.GE1996@nanopsycho> <CAKgT0Ud--R7Mw1_jFckskhGmGLZgZbTZ24TuvJ+UWvm_MAQR9w@mail.gmail.com>
 <20180222081115.GC1994@nanopsycho> <CAJ3xEMiWUY1-zoFTJ9C9QeAGt24bVg-kKO8RkvRa8Agaf2R+0A@mail.gmail.com>
 <20180222130717.GE1994@nanopsycho>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Thu, 22 Feb 2018 07:30:35 -0800
Message-ID: <CAKgT0Ue851QO6zmTfgvqtQr1n61PM5+TzBor1D+kELiJrmc1Ew@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [virtio-dev] Re: [RFC PATCH v3 0/3] Enable virtio_net to act as a backup for a
 passthru device
To: Jiri Pirko <jiri@resnulli.us>
Cc: Or Gerlitz <gerlitz.or@gmail.com>, Jakub Kicinski <kubakici@wp.pl>, "Samudrala, Sridhar" <sridhar.samudrala@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>, Stephen Hemminger <stephen@networkplumber.org>, David Miller <davem@davemloft.net>, Netdev <netdev@vger.kernel.org>, virtualization@lists.linux-foundation.org, virtio-dev@lists.oasis-open.org, "Brandeburg, Jesse" <jesse.brandeburg@intel.com>, "Duyck, Alexander H" <alexander.h.duyck@intel.com>, Jason Wang <jasowang@redhat.com>, Siwei Liu <loseweigh@gmail.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Thu, Feb 22, 2018 at 5:07 AM, Jiri Pirko <jiri@resnulli.us> wrote:
> Thu, Feb 22, 2018 at 12:54:45PM CET, gerlitz.or@gmail.com wrote:
>>On Thu, Feb 22, 2018 at 10:11 AM, Jiri Pirko <jiri@resnulli.us> wrote:
>>> Wed, Feb 21, 2018 at 09:57:09PM CET, alexander.duyck@gmail.com wrote:
>>
>>>>The signaling isn't too much of an issue since we can just tweak the
>>>>link state of the VF or virtio manually to report the link up or down
>>>>prior to the hot-plug. Now that we are on the same page with the team0
>>
>>> Oh, so you just do "ip link set vfrepresentor down" in the host.
>>> That makes sense. I'm pretty sure that this is not implemented for all
>>> drivers now.
>>
>>mlx5 supports that, on the representor close ndo we take the VF link
>>operational v-link down
>>
>>We should probably also put into the picture some/more aspects
>>from the host side of things. The provisioning of the v-switch now
>>have to deal with two channels going into the VM, the PV (virtio)
>>one and the PT (VF) one.
>>
>>This should probably boil down to apply teaming/bonding between
>>the VF representor and a PV backend device, e.g TAP.
>
> Yes, that is correct.

That was my thought on it. If you wanted to you could probably even
look at making the PV the active one in the pair from the host side if
you wanted to avoid the PCIe overhead for things like
broadcast/multicast. The only limitation is that you might need to
have the bond take care of the appropriate switchdev bits so that you
still programmed rules into the hardware even if you are transmitting
down the PV side of the device.

For legacy setups I still need to work on putting together a source
mode macvlan based setup to handle acting like port representors for
the VFs and uplink.

- Alex

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

