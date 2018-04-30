Return-Path: virtio-dev-return-4018-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 5E5685818F5E
	for <virtio-dev@lists.oasis-open.org>; Mon, 30 Apr 2018 12:26:36 -0700 (PDT)
References: <1524848820-42258-1-git-send-email-sridhar.samudrala@intel.com>
 <1524848820-42258-4-git-send-email-sridhar.samudrala@intel.com>
 <20180428082433.GK5632@nanopsycho.orion>
 <62f3b81b-70f6-6991-8e23-2bf650ecea2d@intel.com>
 <20180430071208.GG23854@nanopsycho.orion>
From: "Samudrala, Sridhar" <sridhar.samudrala@intel.com>
Message-ID: <c965d7f2-9ba6-fc82-ce1c-4d70c3aceb6d@intel.com>
Date: Mon, 30 Apr 2018 12:26:34 -0700
MIME-Version: 1.0
In-Reply-To: <20180430071208.GG23854@nanopsycho.orion>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: [virtio-dev] Re: [PATCH net-next v9 3/4] virtio_net: Extend virtio to use VF
 datapath when available
To: Jiri Pirko <jiri@resnulli.us>
Cc: mst@redhat.com, stephen@networkplumber.org, davem@davemloft.net, netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, virtio-dev@lists.oasis-open.org, jesse.brandeburg@intel.com, alexander.h.duyck@intel.com, kubakici@wp.pl, jasowang@redhat.com, loseweigh@gmail.com, aaron.f.brown@intel.com
List-ID: <virtio-dev.lists.oasis-open.org>

On 4/30/2018 12:12 AM, Jiri Pirko wrote:
> Mon, Apr 30, 2018 at 05:00:33AM CEST, sridhar.samudrala@intel.com wrote:
>> On 4/28/2018 1:24 AM, Jiri Pirko wrote:
>>> Fri, Apr 27, 2018 at 07:06:59PM CEST, sridhar.samudrala@intel.com wrote:
>>>> This patch enables virtio_net to switch over to a VF datapath when a VF
>>>> netdev is present with the same MAC address. It allows live migration
>>>> of a VM with a direct attached VF without the need to setup a bond/team
>>>> between a VF and virtio net device in the guest.
>>>>
>>>> The hypervisor needs to enable only one datapath at any time so that
>>>> packets don't get looped back to the VM over the other datapath. When a VF
>>> Why? Both datapaths could be enabled at a time. Why the loop on
>>> hypervisor side would be a problem. This in not an issue for
>>> bonding/team as well.
>> Somehow the hypervisor needs to make sure that the broadcasts/multicasts from the VM
>> sent over the VF datapath don't get looped back to the VM via the virtio-net datapth.
> Why? Please see below.
>
>
>> This can happen if both datapaths are enabled at the same time.
>>
>> I would think this is an issue even with bonding/team as well when virtio-net and
>> VF are backed by the same PF.
>>
>>
> I believe that the scenario is the same as on an ordinary nic/swich
> network:
>
> ...................
>
>    host
>   
>         bond0
>        /     \
>      eth0   eth1
>       |       |
> ...................
>       |       |
>       p1      p2
>
>    switch
>
> ...................
>
> It is perfectly valid to p1 and p2 be up and "bridged" together. Bond
> has to cope with loop-backed frames. "Failover driver" should too,
> it's the same scenario.

OK. So looks like we should be able to handle this by returning RX_HANDLER_EXACT
for frames received on standby device when primary is present.


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

