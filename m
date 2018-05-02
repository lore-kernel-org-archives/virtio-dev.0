Return-Path: virtio-dev-return-4019-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 8F052581806F
	for <virtio-dev@lists.oasis-open.org>; Tue,  1 May 2018 17:20:29 -0700 (PDT)
References: <1524848820-42258-1-git-send-email-sridhar.samudrala@intel.com>
 <1524848820-42258-4-git-send-email-sridhar.samudrala@intel.com>
 <20180428094205.GM5632@nanopsycho.orion>
 <638e52c7-64db-9d8d-7530-f6b000d3e292@intel.com>
 <20180430072034.GH23854@nanopsycho.orion>
From: "Samudrala, Sridhar" <sridhar.samudrala@intel.com>
Message-ID: <9c6f055c-c665-0601-3973-bce74d72544b@intel.com>
Date: Tue, 1 May 2018 17:20:26 -0700
MIME-Version: 1.0
In-Reply-To: <20180430072034.GH23854@nanopsycho.orion>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Subject: [virtio-dev] Re: [PATCH net-next v9 3/4] virtio_net: Extend virtio to use VF
 datapath when available
To: Jiri Pirko <jiri@resnulli.us>
Cc: mst@redhat.com, stephen@networkplumber.org, davem@davemloft.net, netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, virtio-dev@lists.oasis-open.org, jesse.brandeburg@intel.com, alexander.h.duyck@intel.com, kubakici@wp.pl, jasowang@redhat.com, loseweigh@gmail.com, aaron.f.brown@intel.com
List-ID: <virtio-dev.lists.oasis-open.org>

On 4/30/2018 12:20 AM, Jiri Pirko wrote:
>
>>> Now I try to change mac of the failover master:
>>> [root@test1 ~]# ip link set ens3 addr 52:54:00:b2:a7:f3
>>> RTNETLINK answers: Operation not supported
>>>
>>> That I did expect to work. I would expect this would change the mac of
>>> the master and both standby and primary slaves.
>> If a VF is untrusted, a VM will not able to change its MAC and moreover
> Note that at this point, I have no VF. So I'm not sure why you mention
> that.
>
>
>> in this mode we are assuming that the hypervisor has assigned the MAC and
>> guest is not expected to change the MAC.
> Wait, for ordinary old-fashioned virtio_net, as a VM user, I can change
> mac and all works fine. How is this different? Change mac on "failover
> instance" should work and should propagate the mac down to its slaves.
>
>
>> For the initial implementation, i would propose not allowing the guest to
>> change the MAC of failover or standby dev.
> I see no reason for such restriction.
>

It is true that a VM user can change mac address of a normal virtio-net interface,
however when it is in STANDBY mode i think we should not allow this change specifically
because we are creating a failover instance based on a MAC that is assigned by the
hypervisor.

Moreover,  in a cloud environment i would think that PF/hypervisor assigns a MAC to
the VF and it cannot be changed by the guest.

So for the initial implementation, do you see any issues with having this restriction
in STANDBY mode.



---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

