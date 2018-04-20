Return-Path: virtio-dev-return-3924-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 8638A5818F9D
	for <virtio-dev@lists.oasis-open.org>; Fri, 20 Apr 2018 08:46:50 -0700 (PDT)
References: <1524188524-28411-1-git-send-email-sridhar.samudrala@intel.com>
 <1524188524-28411-5-git-send-email-sridhar.samudrala@intel.com>
 <20180420082802.6ca37e4c@xeon-e3>
From: "Samudrala, Sridhar" <sridhar.samudrala@intel.com>
Message-ID: <9cfdc30f-6018-499e-80a8-4447601944a4@intel.com>
Date: Fri, 20 Apr 2018 08:46:48 -0700
MIME-Version: 1.0
In-Reply-To: <20180420082802.6ca37e4c@xeon-e3>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: [virtio-dev] Re: [PATCH v7 net-next 4/4] netvsc: refactor notifier/event handling
 code to use the failover framework
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: mst@redhat.com, davem@davemloft.net, netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, virtio-dev@lists.oasis-open.org, jesse.brandeburg@intel.com, alexander.h.duyck@intel.com, kubakici@wp.pl, jasowang@redhat.com, loseweigh@gmail.com, jiri@resnulli.us
List-ID: <virtio-dev.lists.oasis-open.org>



On 4/20/2018 8:28 AM, Stephen Hemminger wrote:
> On Thu, 19 Apr 2018 18:42:04 -0700
> Sridhar Samudrala <sridhar.samudrala@intel.com> wrote:
>
>> Use the registration/notification framework supported by the generic
>> failover infrastructure.
>>
>> Signed-off-by: Sridhar Samudrala <sridhar.samudrala@intel.com>
> Do what you want to other devices but leave netvsc alone.
> Adding these failover ops does not reduce the code size, and really is
> no benefit.  The netvsc device driver needs to be backported to several
> other distributions and doing this makes that harder.
>
> I will NAK patches to change to common code for netvsc especially the
> three device model.  MS worked hard with distro vendors to support transparent
> mode, ans we really can't have a new model; or do backport.

failover_ops are specifically added to support both 2-netdev and 3-netdev models
This patch doesn't change netvsc model. It still keeps its 2-netdev model. From
netvsc, point of view it is just moving some code from netvsc to the failover module
and also i think the eventhandling and getbymac routines are more optimal.


> Plus, DPDK is now dependent on existing model.


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

