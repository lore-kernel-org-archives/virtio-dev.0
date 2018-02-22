Return-Path: virtio-dev-return-3258-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id D557B5818039
	for <virtio-dev@lists.oasis-open.org>; Wed, 21 Feb 2018 18:15:34 -0800 (PST)
References: <20180220162933.GD2031@nanopsycho>
 <509bbbf9-4db7-dc78-a05e-403452a7407a@intel.com>
 <20180220201410.GF2031@nanopsycho>
 <20180220143356.3467084d@cakuba.netronome.com>
 <20180221095159.GA1996@nanopsycho>
 <CAKgT0UdyhrVr=pYZb=AJq9sWWUVb_BadbJTcqY1AwHHTw8cmQw@mail.gmail.com>
 <20180221161105.GC1996@nanopsycho>
 <CAKgT0Ud+6eiY7ycyju1SToeatH1R7KBDcUOqjn9Pu2k5uOr5Wg@mail.gmail.com>
 <20180221165848.GD1996@nanopsycho>
 <CAKgT0UeZS_SzNfiMX3ujy+a9WZWySVdyTpyQ=b=RJJrAG3JO=w@mail.gmail.com>
 <20180221193832.GE1996@nanopsycho>
 <CAKgT0Ud--R7Mw1_jFckskhGmGLZgZbTZ24TuvJ+UWvm_MAQR9w@mail.gmail.com>
 <20180221180213.30885283@cakuba.netronome.com>
From: "Samudrala, Sridhar" <sridhar.samudrala@intel.com>
Message-ID: <943070f6-7a00-173b-4ea3-587b26097dbc@intel.com>
Date: Wed, 21 Feb 2018 18:15:11 -0800
MIME-Version: 1.0
In-Reply-To: <20180221180213.30885283@cakuba.netronome.com>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Subject: [virtio-dev] Re: [RFC PATCH v3 0/3] Enable virtio_net to act as a backup for a
 passthru device
To: Jakub Kicinski <kubakici@wp.pl>, Alexander Duyck <alexander.duyck@gmail.com>
Cc: Jiri Pirko <jiri@resnulli.us>, "Michael S. Tsirkin" <mst@redhat.com>, Stephen Hemminger <stephen@networkplumber.org>, David Miller <davem@davemloft.net>, Netdev <netdev@vger.kernel.org>, virtualization@lists.linux-foundation.org, virtio-dev@lists.oasis-open.org, "Brandeburg, Jesse" <jesse.brandeburg@intel.com>, "Duyck, Alexander H" <alexander.h.duyck@intel.com>, Jason Wang <jasowang@redhat.com>, Siwei Liu <loseweigh@gmail.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On 2/21/2018 6:02 PM, Jakub Kicinski wrote:
> On Wed, 21 Feb 2018 12:57:09 -0800, Alexander Duyck wrote:
>>> I don't see why the team cannot be there always.
>> It is more the logistical nightmare. Part of the goal here was to work
>> with the cloud base images that are out there such as
>> https://alt.fedoraproject.org/cloud/. With just the kernel changes the
>> overhead for this stays fairly small and would be pulled in as just a
>> standard part of the kernel update process. The virtio bypass only
>> pops up if the backup bit is present. With the team solution it
>> requires that the base image use the team driver on virtio_net when it
>> sees one. I doubt the OSVs would want to do that just because SR-IOV
>> isn't that popular of a case.
> IIUC we need to monitor for a "backup hint", spawn the master, rename it
> to maintain backwards compatibility with no-VF setups and enslave the VF
> if it appears.
>
> All those sound possible from user space, the advantage of the kernel
> solution right now is that it has more complete code.
>
> Am I misunderstanding?

I think there is some misunderstanding about the exact requirement and 
the usecase
we are trying to solve.  If the Guest is allowed to do this 
configuration, we already have
a solution with either bond/team based user space configuration.

This is to enable cloud service providers to provide a accelerated 
datapath by simply
letting to tenants to get their own images with the only requirement to 
enable their
kernels with newer virtio_net driver with BACKUP support and the VF driver.

To recap from an earlier thread, here is a response from Stephen that 
talks about the
requirement for the netvsc solution and we would like to provide similar 
solution for
KVM based cloud deployments.

 > The requirement with Azure accelerated network was that a stock 
distribution image from the
 > store must be able to run unmodified and get accelerated networking.
 >  Not sure if other environments need to work the same, but it would 
be nice.
 >  That meant no additional setup scripts (aka no bonding) and also it must
 > work transparently with hot-plug. Also there are diverse set of 
environments:
 > openstack, cloudinit, network manager and systemd. The solution had 
to not depend
 > on any one of them, but also not break any of them.

Thanks
Sridhar

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

