Return-Path: virtio-dev-return-3409-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 61D895818F68
	for <virtio-dev@lists.oasis-open.org>; Sun,  4 Mar 2018 13:54:53 -0800 (PST)
References: <20180302083605.GD2099@nanopsycho>
 <CAKgT0UeMQ8GkHLrCHQ_OfFw3beqHVM2QvbRt7zoZKf1Vwvbt1A@mail.gmail.com>
 <20180302162017.GG2099@nanopsycho>
 <20180302214114-mutt-send-email-mst@kernel.org>
 <20180303113120.GA3205@nanopsycho.orion>
 <CAKgT0UcdJ0D-64N0cKsZtpqyKWsXkoPTdvRPxoCrpU=q1T8UuA@mail.gmail.com>
 <20180303212542.GA10132@nanopsycho.orion>
 <CAKgT0UeH3JGGEvwwFfjpde=iPwV7s2MEwhKk08ixedCXZHcCFg@mail.gmail.com>
 <20180304071329.GA2112@nanopsycho.orion>
 <CAKgT0UfHg6OfLzYGSo2vM9PCqpajHW-RAEJ0WQbx6NT8H_AQDg@mail.gmail.com>
 <20180304185034.GE2112@nanopsycho.orion>
From: "Samudrala, Sridhar" <sridhar.samudrala@intel.com>
Message-ID: <3089ef58-4756-e67e-4511-652aa095e25f@intel.com>
Date: Sun, 4 Mar 2018 13:54:49 -0800
MIME-Version: 1.0
In-Reply-To: <20180304185034.GE2112@nanopsycho.orion>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: [virtio-dev] Re: [PATCH v4 2/2] virtio_net: Extend virtio to use VF datapath when
 available
To: Jiri Pirko <jiri@resnulli.us>, Alexander Duyck <alexander.duyck@gmail.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Stephen Hemminger <stephen@networkplumber.org>, David Miller <davem@davemloft.net>, Netdev <netdev@vger.kernel.org>, virtio-dev@lists.oasis-open.org, "Brandeburg, Jesse" <jesse.brandeburg@intel.com>, "Duyck, Alexander H" <alexander.h.duyck@intel.com>, Jakub Kicinski <kubakici@wp.pl>
List-ID: <virtio-dev.lists.oasis-open.org>



On 3/4/2018 10:50 AM, Jiri Pirko wrote:
> Sun, Mar 04, 2018 at 07:24:12PM CET, alexander.duyck@gmail.com wrote:
>> On Sat, Mar 3, 2018 at 11:13 PM, Jiri Pirko <jiri@resnulli.us> wrote:
>>> Sun, Mar 04, 2018 at 01:26:53AM CET, alexander.duyck@gmail.com wrote:
>>>> On Sat, Mar 3, 2018 at 1:25 PM, Jiri Pirko <jiri@resnulli.us> wrote:
>>>>> Sat, Mar 03, 2018 at 07:04:57PM CET, alexander.duyck@gmail.com wrote:
>>>>>> On Sat, Mar 3, 2018 at 3:31 AM, Jiri Pirko <jiri@resnulli.us> wrote:
>>>>>>> Fri, Mar 02, 2018 at 08:42:47PM CET, mst@redhat.com wrote:
>>>>>>>> On Fri, Mar 02, 2018 at 05:20:17PM +0100, Jiri Pirko wrote:
>>>>>>>>>> Yeah, this code essentially calls out the "shareable" code with a
>>>>>>>>>> comment at the start and end of the section what defines the
>>>>>>>>>> virtio_bypass functionality. It would just be a matter of mostly
>>>>>>>>>> cutting and pasting to put it into a separate driver module.
>>>>>>>>> Please put it there and unite the use of it with netvsc.
>>>>>>>> Surely, adding this to other drivers (e.g. might this be handy for xen
>>>>>>>> too?) can be left for a separate patchset. Let's get one device merged
>>>>>>>> first.
>>>>>>> Why? Let's do the generic infra alongside with the driver. I see no good
>>>>>>> reason to rush into merging driver and only later, if ever, to convert
>>>>>>> it to generic solution. On contrary. That would lead into multiple
>>>>>>> approaches and different behavious in multiple drivers. That is plain
>>>>>>> wrong.
>>>>>> If nothing else it doesn't hurt to do this in one driver in a generic
>>>>>> way, and once it has been proven to address all the needs of that one
>>>>>> driver we can then start moving other drivers to it. The current
>>>>>> solution is quite generic, that was my contribution to this patch set
>>>>>> as I didn't like how invasive it was being to virtio and thought it
>>>>>> would be best to keep this as minimally invasive as possible.
>>>>>>
>>>>>> My preference would be to give this a release or two in virtio to
>>>>>> mature before we start pushing it onto other drivers. It shouldn't
>>>>>> take much to cut/paste this into a new driver file once we decide it
>>>>>> is time to start extending it out to other drivers.
>>>>> I'm not talking about cut/paste and in fact that is what I'm worried
>>>>> about. I'm talking about common code in net/core/ or somewhere that
>>>>> would take care of this in-driver bonding. Each driver, like virtio_net,
>>>>> netvsc would just register some ops to it and the core would do all
>>>>> logic. I believe it is essential take this approach from the start.
>>>> Sorry, I didn't mean cut/paste into another driver, I meant to make it
>>>> a driver of its own. My thought was to eventually create a shared/core
>>>> driver module that is then used by the other drivers.
>>>>
>>>> My concern right now is that Stephen has indicated he doesn't want
>>>> this approach taken with netvsc, and most of the community doesn't
>>> IIUC, he only does not like the extra netdev. Is there anything else?
>> Nope that is pretty much it. It doesn't seem like a big deal for
>> virtio, but for netvsc it is significant since they don't have any
>> "backup" bit feature differentiation, so they would likely be stuck
>> with 2 netdevs even in their basic setup.
> Okay. If that is a strict "no-go" for netvsc, this should be
> just a flag passed down to the in-driver bond code.

This results in a 3 driver model (virtio/netvsc, vf & bypass) with 2 netdevs
created when bypass is based on netvsc and 3 netdevs created when the bypass
is based on virtio_net.

Unless we agree on a common netdev model between netvsc and virtio_net,
i am not sure if it is useful to commonize the code into a separate driver.

-Sridhar

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

