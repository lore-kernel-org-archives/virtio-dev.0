Return-Path: virtio-dev-return-3403-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 0D6B25818081
	for <virtio-dev@lists.oasis-open.org>; Sat,  3 Mar 2018 10:05:09 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180303113120.GA3205@nanopsycho.orion>
References: <1519934923-39372-1-git-send-email-sridhar.samudrala@intel.com>
 <1519934923-39372-3-git-send-email-sridhar.samudrala@intel.com>
 <20180302083605.GD2099@nanopsycho> <CAKgT0UeMQ8GkHLrCHQ_OfFw3beqHVM2QvbRt7zoZKf1Vwvbt1A@mail.gmail.com>
 <20180302162017.GG2099@nanopsycho> <20180302214114-mutt-send-email-mst@kernel.org>
 <20180303113120.GA3205@nanopsycho.orion>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Sat, 3 Mar 2018 10:04:57 -0800
Message-ID: <CAKgT0UcdJ0D-64N0cKsZtpqyKWsXkoPTdvRPxoCrpU=q1T8UuA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [virtio-dev] Re: [PATCH v4 2/2] virtio_net: Extend virtio to use VF datapath when available
To: Jiri Pirko <jiri@resnulli.us>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Sridhar Samudrala <sridhar.samudrala@intel.com>, Stephen Hemminger <stephen@networkplumber.org>, David Miller <davem@davemloft.net>, Netdev <netdev@vger.kernel.org>, virtio-dev@lists.oasis-open.org, "Brandeburg, Jesse" <jesse.brandeburg@intel.com>, "Duyck, Alexander H" <alexander.h.duyck@intel.com>, Jakub Kicinski <kubakici@wp.pl>
List-ID: <virtio-dev.lists.oasis-open.org>

On Sat, Mar 3, 2018 at 3:31 AM, Jiri Pirko <jiri@resnulli.us> wrote:
> Fri, Mar 02, 2018 at 08:42:47PM CET, mst@redhat.com wrote:
>>On Fri, Mar 02, 2018 at 05:20:17PM +0100, Jiri Pirko wrote:
>>> >Yeah, this code essentially calls out the "shareable" code with a
>>> >comment at the start and end of the section what defines the
>>> >virtio_bypass functionality. It would just be a matter of mostly
>>> >cutting and pasting to put it into a separate driver module.
>>>
>>> Please put it there and unite the use of it with netvsc.
>>
>>Surely, adding this to other drivers (e.g. might this be handy for xen
>>too?) can be left for a separate patchset. Let's get one device merged
>>first.
>
> Why? Let's do the generic infra alongside with the driver. I see no good
> reason to rush into merging driver and only later, if ever, to convert
> it to generic solution. On contrary. That would lead into multiple
> approaches and different behavious in multiple drivers. That is plain
> wrong.

If nothing else it doesn't hurt to do this in one driver in a generic
way, and once it has been proven to address all the needs of that one
driver we can then start moving other drivers to it. The current
solution is quite generic, that was my contribution to this patch set
as I didn't like how invasive it was being to virtio and thought it
would be best to keep this as minimally invasive as possible.

My preference would be to give this a release or two in virtio to
mature before we start pushing it onto other drivers. It shouldn't
take much to cut/paste this into a new driver file once we decide it
is time to start extending it out to other drivers.

- Alex

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

