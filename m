Return-Path: virtio-dev-return-4122-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id DBE6A5818E24
	for <virtio-dev@lists.oasis-open.org>; Tue, 22 May 2018 08:28:45 -0700 (PDT)
References: <1526954781-35359-1-git-send-email-sridhar.samudrala@intel.com>
 <1526954781-35359-3-git-send-email-sridhar.samudrala@intel.com>
 <20180522090637.GE2149@nanopsycho> <20180522090853.GF2149@nanopsycho>
From: "Samudrala, Sridhar" <sridhar.samudrala@intel.com>
Message-ID: <39081bce-3913-5b07-3d07-0c476fca5e78@intel.com>
Date: Tue, 22 May 2018 08:28:42 -0700
MIME-Version: 1.0
In-Reply-To: <20180522090853.GF2149@nanopsycho>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Subject: [virtio-dev] Re: [PATCH net-next v11 2/5] netvsc: refactor notifier/event handling
 code to use the failover framework
To: Jiri Pirko <jiri@resnulli.us>
Cc: mst@redhat.com, stephen@networkplumber.org, davem@davemloft.net, netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, virtio-dev@lists.oasis-open.org, jesse.brandeburg@intel.com, alexander.h.duyck@intel.com, kubakici@wp.pl, jasowang@redhat.com, loseweigh@gmail.com, aaron.f.brown@intel.com, anjali.singhai@intel.com
List-ID: <virtio-dev.lists.oasis-open.org>


On 5/22/2018 2:08 AM, Jiri Pirko wrote:
> Tue, May 22, 2018 at 11:06:37AM CEST, jiri@resnulli.us wrote:
>> Tue, May 22, 2018 at 04:06:18AM CEST, sridhar.samudrala@intel.com wrote:
>>> Use the registration/notification framework supported by the generic
>>> failover infrastructure.
>>>
>>> Signed-off-by: Sridhar Samudrala <sridhar.samudrala@intel.com>
>> In previous patchset versions, the common code did
>> netdev_rx_handler_register() and netdev_upper_dev_link() etc
>> (netvsc_vf_join()). Now, this is still done in netvsc. Why?
>>
>> This should be part of the common "failover" code.

Based on Stephen's feedback on earlier patches, i tried to minimize the changes to
netvsc and only commonize the notifier and the main event handler routine.
Another complication is that netvsc does part of registration in a delayed workqueue.

It should be possible to move some of the code from net_failover.c to generic
failover.c in future if Stephen is ok with it.


>>
> Also note that in the current patchset you use IFF_FAILOVER flag for
> master, yet for the slave you use IFF_SLAVE. That is wrong.
> IFF_FAILOVER_SLAVE should be used.

Not sure which code you are referring to.  I only set IFF_FAILOVER_SLAVE
in patch 3.


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

