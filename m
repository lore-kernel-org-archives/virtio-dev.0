Return-Path: virtio-dev-return-5129-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 74D0D985ED1
	for <virtio-dev@lists.oasis-open.org>; Wed,  5 Dec 2018 17:18:17 +0000 (UTC)
Date: Wed, 5 Dec 2018 12:18:13 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20181205121405-mutt-send-email-mst@kernel.org>
References: <20181128135154-mutt-send-email-mst@kernel.org>
 <1aeab969-f47f-42c3-31a0-b4c5df647d58@oracle.com>
 <20181128195226-mutt-send-email-mst@kernel.org>
 <cca54913-42c0-55bf-986e-8670c49fb8fe@oracle.com>
 <20181129160950-mutt-send-email-mst@kernel.org>
 <2f44fe5e-ee7d-96cd-dd85-f663fa04c7d0@oracle.com>
 <20181130004530-mutt-send-email-mst@kernel.org>
 <3035130f-ad02-39d7-a897-aec3a3f2fee5@oracle.com>
 <20181203224508-mutt-send-email-mst@kernel.org>
 <CAKPgXcF-GXoi99pk5VeLe=vN2QZZutedrLqCRMJpdZrowyj7jw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKPgXcF-GXoi99pk5VeLe=vN2QZZutedrLqCRMJpdZrowyj7jw@mail.gmail.com>
Subject: Re: [virtio-dev] [PATCH v4] content: Introduce VIRTIO_NET_F_STANDBY
 feature
To: Sameeh Jubran <sameeh@daynix.com>
Cc: si-wei.liu@oracle.com, sridhar.samudrala@intel.com, carolyn.wyborny@intel.com, Siwei Liu <loseweigh@gmail.com>, venu.busireddy@oracle.com, cohuck@redhat.com, virtio-dev <virtio-dev@lists.oasis-open.org>, liran.alon@oracle.com, Yan Vugenfirer <yan@daynix.com>, jesse.brandeburg@intel.com, boris.ostrovsky@oracle.com
List-ID: <virtio-dev.lists.oasis-open.org>

On Wed, Dec 05, 2018 at 06:18:05PM +0200, Sameeh Jubran wrote:
> Hi all,
> 
> This is a followup on the discussion in the DPDK and Virtio monthly meeting.
> 
> Michael suggested that layer 2 tests should be created in order to
> test the PF/VF behavior in different scenarios without using VMs at
> all which should speed up the testing process.
> 
> The following "mausezahn" tool - which is part of netsniff-ng package
> - can be used in order to generate layer 2 packets as follows:
> 
> mausezahn enp59s0 -c 0 -a rand -b 20:71:c6:2a:68:38 "08 00 aa bb cc dd"
> 
> The packets can be sniffed using tcpdump or netsniff-ng.
> 
> I am not completely sure how the setup should look like on the host,
> but here is a script which assigns macvlan to the PF and sets it's mac
> address to be the same as the VF mac address. The scripts assumes that
> the sriov is already configured and the vf are present.
> 
> [root@wsfd-advnetlab10 ~]# cat go_macvlan.sh
> MACVLAN_NAME=macvlan0
> PF_NAME=enp59s0
> VF_NUMBER=1
> MAC_ADDR=20:71:c6:2a:68:38
> 
> echo "$PF_NAME vf status before setting mac"
> ip link show dev $PF_NAME
> ip link set $PF_NAME vf $VF_NUMBER mac $MAC_ADDR
> ip li add link $PF_NAME $MACVLAN_NAME address $MAC_ADDR type macvlan
> ip link set $PF_NAME up
> echo "$PF_NAME vf status after setting mac"
> ip link show dev $PF_NAME
> 
> Please share your thoughts on how the different test scenarios should
> go, I can customize the scripts further more and host them somewhere.

OK so for starters need code to send the packets (maybe
multiple ones with a counter so drops can be detected?)
and also to sniff and verify their arrival on either of
the two interfaces?

And then on top there would be all the different ways
to switch between the two interfaces back and forth
while this is going on.

The tool would ideally do this several times with each method and report
observed downtime.


-- 
MST

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

