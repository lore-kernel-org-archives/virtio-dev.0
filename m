Return-Path: virtio-dev-return-5522-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id DB5C3985B92
	for <virtio-dev@lists.oasis-open.org>; Tue, 26 Feb 2019 00:57:18 +0000 (UTC)
References: <1523386790-12396-1-git-send-email-sridhar.samudrala@intel.com>
 <1523386790-12396-5-git-send-email-sridhar.samudrala@intel.com>
 <20180410142608.50f15b45@xeon-e3> <20180411075334.GK2028@nanopsycho>
 <CADGSJ214RJV_zWVBGv0Ydo=CJj6WESTYAH=PpaYLFHdtWVrm3g@mail.gmail.com>
 <20190221203808-mutt-send-email-mst@kernel.org>
 <581e4399-3969-aecd-e923-03bbc0880733@oracle.com>
 <91d4cbb1-be7a-b53c-6b2a-99bef07e7c53@intel.com>
 <d9ef40a2-237b-0cce-4401-ecaeac4c602a@oracle.com>
 <20190222100753-mutt-send-email-mst@kernel.org>
From: si-wei liu <si-wei.liu@oracle.com>
Message-ID: <e6a53bd1-83ab-f170-406a-03276e8c87e2@oracle.com>
Date: Mon, 25 Feb 2019 16:58:07 -0800
MIME-Version: 1.0
In-Reply-To: <20190222100753-mutt-send-email-mst@kernel.org>
Content-Type: multipart/mixed;
 boundary="------------10FAAC2262C0FD1C74C40294"
Content-Language: en-US
Subject: Re: [virtio-dev] Re: net_failover slave udev renaming (was Re: [RFC
 PATCH net-next v6 4/4] netvsc: refactor notifier/event handling code to use
 the bypass framework)
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: "Samudrala, Sridhar" <sridhar.samudrala@intel.com>, Siwei Liu <loseweigh@gmail.com>, Jiri Pirko <jiri@resnulli.us>, Stephen Hemminger <stephen@networkplumber.org>, David Miller <davem@davemloft.net>, Netdev <netdev@vger.kernel.org>, virtualization@lists.linux-foundation.org, virtio-dev <virtio-dev@lists.oasis-open.org>, "Brandeburg, Jesse" <jesse.brandeburg@intel.com>, Alexander Duyck <alexander.h.duyck@intel.com>, Jakub Kicinski <kubakici@wp.pl>, Jason Wang <jasowang@redhat.com>, liran.alon@oracle.com
List-ID: <virtio-dev.lists.oasis-open.org>

--------------10FAAC2262C0FD1C74C40294
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2/22/2019 7:14 AM, Michael S. Tsirkin wrote:
> On Thu, Feb 21, 2019 at 11:55:11PM -0800, si-wei liu wrote:
>>
>> On 2/21/2019 11:00 PM, Samudrala, Sridhar wrote:
>>>
>>> On 2/21/2019 7:33 PM, si-wei liu wrote:
>>>>
>>>> On 2/21/2019 5:39 PM, Michael S. Tsirkin wrote:
>>>>> On Thu, Feb 21, 2019 at 05:14:44PM -0800, Siwei Liu wrote:
>>>>>> Sorry for replying to this ancient thread. There was some remaining
>>>>>> issue that I don't think the initial net_failover patch got addressed
>>>>>> cleanly, see:
>>>>>>
>>>>>> https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1815268
>>>>>>
>>>>>> The renaming of 'eth0' to 'ens4' fails because the udev userspace was
>>>>>> not specifically writtten for such kernel automatic enslavement.
>>>>>> Specifically, if it is a bond or team, the slave would typically get
>>>>>> renamed *before* virtual device gets created, that's what udev can
>>>>>> control (without getting netdev opened early by the other part of
>>>>>> kernel) and other userspace components for e.g. initramfs,
>>>>>> init-scripts can coordinate well in between. The in-kernel
>>>>>> auto-enslavement of net_failover breaks this userspace convention,
>>>>>> which don't provides a solution if user care about consistent naming
>>>>>> on the slave netdevs specifically.
>>>>>>
>>>>>> Previously this issue had been specifically called out when IFF_HIDDEN
>>>>>> and the 1-netdev was proposed, but no one gives out a solution to this
>>>>>> problem ever since. Please share your mind how to proceed and solve
>>>>>> this userspace issue if netdev does not welcome a 1-netdev model.
>>>>> Above says:
>>>>>
>>>>>      there's no motivation in the systemd/udevd community at
>>>>>      this point to refactor the rename logic and make it work well with
>>>>>      3-netdev.
>>>>>
>>>>> What would the fix be? Skip slave devices?
>>>>>
>>>> There's nothing user can get if just skipping slave devices - the
>>>> name is still unchanged and unpredictable e.g. eth0, or eth1 the
>>>> next reboot, while the rest may conform to the naming scheme (ens3
>>>> and such). There's no way one can fix this in userspace alone - when
>>>> the failover is created the enslaved netdev was opened by the kernel
>>>> earlier than the userspace is made aware of, and there's no
>>>> negotiation protocol for kernel to know when userspace has done
>>>> initial renaming of the interface. I would expect netdev list should
>>>> at least provide the direction in general for how this can be
>>>> solved...
>
> I was just wondering what did you mean when you said
> "refactor the rename logic and make it work well with 3-netdev" -
> was there a proposal udev rejected?
No. I never believed this particular issue can be fixed in userspace 
alone. Previously someone had said it could be, but I never see any work 
or relevant discussion ever happened in various userspace communities 
(for e.g. dracut, initramfs-tools, systemd, udev, and NetworkManager). 
IMHO the root of the issue derives from the kernel, it makes more sense 
to start from netdev, work out and decide on a solution: see what can be 
done in the kernel in order to fix it, then after that engage userspace 
community for the feasibility...

> Anyway, can we write a time diagram for what happens in which order that
> leads to failure?  That would help look for triggers that we can tie
> into, or add new ones.
>

See attached diagram.

>
>
>
>
>>> Is there an issue if slave device names are not predictable? The user/admin scripts are expected
>>> to only work with the master failover device.
>> Where does this expectation come from?
>>
>> Admin users may have ethtool or tc configurations that need to deal with
>> predictable interface name. Third-party app which was built upon specifying
>> certain interface name can't be modified to chase dynamic names.
>>
>> Specifically, we have pre-canned image that uses ethtool to fine tune VF
>> offload settings post boot for specific workload. Those images won't work
>> well if the name is constantly changing just after couple rounds of live
>> migration.
> It should be possible to specify the ethtool configuration on the
> master and have it automatically propagated to the slave.
>
> BTW this is something we should look at IMHO.
I was elaborating a few examples that the expectation and assumption 
that user/admin scripts only deal with master failover device is 
incorrect. It had never been taken good care of, although I did try to 
emphasize it from the very beginning.

Basically what you said about propagating the ethtool configuration down 
to the slave is the key pursuance of 1-netdev model. However, what I am 
seeking now is any alternative that can also fix the specific udev 
rename problem, before concluding that 1-netdev is the only solution. 
Generally a 1-netdev scheme would take time to implement, while I'm 
trying to find a way out to fix this particular naming problem under 
3-netdev.

>
>>> Moreover, you were suggesting hiding the lower slave devices anyway. There was some discussion
>>> about moving them to a hidden network namespace so that they are not visible from the default namespace.
>>> I looked into this sometime back, but did not find the right kernel api to create a network namespace within
>>> kernel. If so, we could use this mechanism to simulate a 1-netdev model.
>> Yes, that's one possible implementation (IMHO the key is to make 1-netdev
>> model as much transparent to a real NIC as possible, while a hidden netns is
>> just the vehicle). However, I recall there was resistance around this
>> discussion that even the concept of hiding itself is a taboo for Linux
>> netdev. I would like to summon potential alternatives before concluding
>> 1-netdev is the only solution too soon.
>>
>> Thanks,
>> -Siwei
> Your scripts would not work at all then, right?
At this point we don't claim images with such usage as SR-IOV live 
migrate-able. We would flag it as live migrate-able until this ethtool 
config issue is fully addressed and a transparent live migration 
solution emerges in upstream eventually.


Thanks,
-Siwei
>
>
>>>> -Siwei
>>>>
>>>>
> ---------------------------------------------------------------------
> To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
> For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org
>


--------------10FAAC2262C0FD1C74C40294
Content-Type: text/plain; charset=UTF-8;
 name="net_failover_rename_race.txt"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="net_failover_rename_race.txt"

DQogIG5ldF9mYWlsb3ZlcihrZXJuZWwpICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwg
ICAgbmV0d29yay5zZXJ2aWNlICh1c2VyKSAgICB8ICAgICAgICAgIHN5c3RlbWQtdWRldmQg
KHVzZXIpDQotLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLSstLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0rLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCihzdGFuZGJ5IHZpcnRpby1uZXQgYW5kIG5l
dF9mYWlsb3ZlciAgICAgICAgICAgICAgfCAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IHwNCmRldmljZXMgY3JlYXRlZCBhbmQgaW5pdGlhbGl6ZWQsICAgICAgICAgICAgICAgICAg
fCAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwNCmkuZS4gdmlydG5ldF9wcm9iZSgp
LT4gICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIHwNCiAgICAgICBuZXRfZmFpbG92ZXJfY3JlYXRlKCkgICAgICAgICAgICAgICAg
ICAgICAgfCAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwNCndhcyBkb25lLikgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIHwNCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgfCAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwNCiAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgcnVucyBgaWZ1
cCBlbnMzJyAtPiAgICAgICAgIHwNCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgfCAgICBpcCBsaW5rIHNldCBkZXYgZW5zMyB1cCAgIHwNCm5l
dF9mYWlsb3Zlcl9vcGVuKCkgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIHwNCiAgZGV2X29wZW4odmlydG5ldF9kZXYpICAg
ICAgICAgICAgICAgICAgICAgICAgICAgfCAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IHwNCiAgICB2aXJ0bmV0X29wZW4odmlydG5ldF9kZXYpICAgICAgICAgICAgICAgICAgICAg
fCAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwNCiAgbmV0aWZfY2Fycmllcl9vbihm
YWlsb3Zlcl9kZXYpICAgICAgICAgICAgICAgICAgfCAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIHwNCiAgLi4uICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgfCAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwNCiAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIHwNCihWRiBob3QgcGx1Z2dlZCBpbikgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgfCAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwNCml4Z2JldmZf
cHJvYmUoKSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIHwNCiByZWdpc3Rlcl9uZXRkZXYoaXhnYmV2Zl9uZXRkZXYp
ICAgICAgICAgICAgICAgICAgfCAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwNCiAg
bmV0ZGV2X3JlZ2lzdGVyX2tvYmplY3QoaXhnYmV2Zl9uZXRkZXYpICAgICAgICAgfCAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIHwNCiAgIGtvYmplY3RfYWRkKGl4Z2JldmZfZGV2
KSAgICAgICAgICAgICAgICAgICAgICAgfCAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IHwNCiAgICBkZXZpY2VfYWRkKGl4Z2JldmZfZGV2KSAgICAgICAgICAgICAgICAgICAgICAg
fCAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwNCiAgICAga29iamVjdF91ZXZlbnQo
Jml4Z2JldmZfZGV2LT5rb2JqLCBLT0JKX0FERCkgfCAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIHwNCiAgICAgIG5ldGxpbmtfYnJvYWRjYXN0KCkgICAgICAgICAgICAgICAgICAg
ICAgICAgfCAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwNCiAgLi4uICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIHwNCiAgY2FsbF9uZXRkZXZpY2Vfbm90aWZpZXJzKE5FVERFVl9SRUdJ
U1RFUikgICAgICAgfCAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwNCiAgIGZhaWxv
dmVyX2V2ZW50KC4uLiwgTkVUREVWX1JFR0lTVEVSLCAuLi4pICAgICAgfCAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIHwNCiAgICBmYWlsb3Zlcl9zbGF2ZV9yZWdpc3RlcihpeGdi
ZXZmX25ldGRldikgICAgICAgfCAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwNCiAg
ICAgbmV0X2ZhaWxvdmVyX3NsYXZlX3JlZ2lzdGVyKGl4Z2JldmZfbmV0ZGV2KSAgfCAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIHwNCiAgICAgIGRldl9vcGVuKGl4Z2JldmZfbmV0
ZGV2KSAgICAgICAgICAgICAgICAgICAgfCAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IHwNCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
fCAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwNCiAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIHwNCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgfCAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgICByZWNlaXZlZCBBREQg
dWV2ZW50IGZyb20gbmV0bGluayBmZA0KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICB8ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAg
IC4uLg0KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICB8ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgIHVkZXYtYnVpbHRpbi1uZXRf
aWQuYzpkZXZfcGNpX3Nsb3QoKQ0KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICB8ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgIChk
ZWNpZGVkIHRvIHJlbmFtZWQgJ2V0aDAnICkNCiAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgfCAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IHwgICAgIGlwIGxpbmsgc2V0IGRldiBldGgwIG5hbWUgZW5zNA0KKGRldl9jaGFuZ2VfbmFt
ZSgpIHJldHVybnMgLUVCVVNZIGFzICAgICAgICAgICAgICB8ICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgfA0KaXhnYmV2Zl9uZXRkZXYtPmZsYWdzIGhhcyBJRkZfVVApICAgICAg
ICAgICAgICAgICB8ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfA0KICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgfA0KDQo=

--------------10FAAC2262C0FD1C74C40294
Content-Type: text/plain; charset=us-ascii


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org
--------------10FAAC2262C0FD1C74C40294--
