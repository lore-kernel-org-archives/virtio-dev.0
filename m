Return-Path: virtio-dev-return-4129-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 124255818F54
	for <virtio-dev@lists.oasis-open.org>; Tue, 22 May 2018 13:54:42 -0700 (PDT)
References: <1526954781-35359-1-git-send-email-sridhar.samudrala@intel.com>
 <1526954781-35359-3-git-send-email-sridhar.samudrala@intel.com>
 <20180522090637.GE2149@nanopsycho> <20180522090853.GF2149@nanopsycho>
 <39081bce-3913-5b07-3d07-0c476fca5e78@intel.com>
 <20180522153614.GK2149@nanopsycho>
 <20180522184112-mutt-send-email-mst@kernel.org>
 <20180522161246.GN2149@nanopsycho>
From: "Samudrala, Sridhar" <sridhar.samudrala@intel.com>
Message-ID: <8f611f3b-88d7-4d41-fd47-d07f11d0f25a@intel.com>
Date: Tue, 22 May 2018 13:54:29 -0700
MIME-Version: 1.0
In-Reply-To: <20180522161246.GN2149@nanopsycho>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Subject: [virtio-dev] Re: [PATCH net-next v11 2/5] netvsc: refactor notifier/event handling
 code to use the failover framework
To: Jiri Pirko <jiri@resnulli.us>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: stephen@networkplumber.org, davem@davemloft.net, netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, virtio-dev@lists.oasis-open.org, jesse.brandeburg@intel.com, alexander.h.duyck@intel.com, kubakici@wp.pl, jasowang@redhat.com, loseweigh@gmail.com, aaron.f.brown@intel.com, anjali.singhai@intel.com
List-ID: <virtio-dev.lists.oasis-open.org>



On 5/22/2018 9:12 AM, Jiri Pirko wrote:
> Fixing the subj, sorry about that.
>
> Tue, May 22, 2018 at 05:46:21PM CEST, mst@redhat.com wrote:
>> On Tue, May 22, 2018 at 05:36:14PM +0200, Jiri Pirko wrote:
>>> Tue, May 22, 2018 at 05:28:42PM CEST, sridhar.samudrala@intel.com wrote:
>>>> On 5/22/2018 2:08 AM, Jiri Pirko wrote:
>>>>> Tue, May 22, 2018 at 11:06:37AM CEST, jiri@resnulli.us wrote:
>>>>>> Tue, May 22, 2018 at 04:06:18AM CEST, sridhar.samudrala@intel.com wrote:
>>>>>>> Use the registration/notification framework supported by the generic
>>>>>>> failover infrastructure.
>>>>>>>
>>>>>>> Signed-off-by: Sridhar Samudrala <sridhar.samudrala@intel.com>
>>>>>> In previous patchset versions, the common code did
>>>>>> netdev_rx_handler_register() and netdev_upper_dev_link() etc
>>>>>> (netvsc_vf_join()). Now, this is still done in netvsc. Why?
>>>>>>
>>>>>> This should be part of the common "failover" code.
>>>> Based on Stephen's feedback on earlier patches, i tried to minimize the changes to
>>>> netvsc and only commonize the notifier and the main event handler routine.
>>>> Another complication is that netvsc does part of registration in a delayed workqueue.
>>> :( This kind of degrades the whole efford of having single solution
>>> in "failover" module. I think that common parts, as
>>> netdev_rx_handler_register() and others certainly is should be inside
>>> the common module. This is not a good time to minimize changes. Let's do
>>> the thing properly and fix the netvsc mess now.
>>>
>>>
>>>> It should be possible to move some of the code from net_failover.c to generic
>>>> failover.c in future if Stephen is ok with it.
>>>>
>>>>
>>>>> Also note that in the current patchset you use IFF_FAILOVER flag for
>>>>> master, yet for the slave you use IFF_SLAVE. That is wrong.
>>>>> IFF_FAILOVER_SLAVE should be used.
>>>> Not sure which code you are referring to.  I only set IFF_FAILOVER_SLAVE
>>>> in patch 3.
>>> The existing netvsc driver.
>> We really can't change netvsc's flags now, even if it's interface is
>> messy, it's being used in the field. We can add a flag that makes netvsc
>> behave differently, and if this flag also allows enhanced functionality
>> userspace will gradually switch.
> Okay, although in this case, it really does not make much sense, so be
> it. Leave the netvsc set the ->priv flag to IFF_SLAVE as it is doing
> now. (This once-wrong-forever-wrong policy is flustrating me).
>
> But since this patchset introduces private flag IFF_FAILOVER and
> IFF_FAILOVER_SLAVE, and we set IFF_FAILOVER to the netvsc netdev
> instance, we should also set IFF_FAILOVER_SLAVE to the enslaved VF
> netdevice to get at least some consistency between virtio_net and
> netvsc.

OK. I can make this change to set/unset IFF_FAILOVER_SLAVE in the netvsc
register/unregister routines so that it is consistent with virtio_net.

Based on your discussion with mst, i think we can even remove IFF_SLAVE
setting on netvsc as it should not impact userspace.  If Stephen is OK
we can make this change too.

Do you see any other items that need to be resolved for this series to go in
this merge window?



>
>> Anything breaking userspace I fully expect Stephen to nack and
>> IMO with good reason.
>>
>> -- 
>> MST


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

