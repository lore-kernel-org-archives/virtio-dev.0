Return-Path: <virtio-dev-return-8509-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 0F0B8986279
	for <virtio-dev@lists.oasis-open.org>; Mon,  9 Aug 2021 05:51:01 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
In-Reply-To: <20210809041544.272ykb6mtg2xpucj@vireshk-i7>
References: <cover.1627627021.git.viresh.kumar@linaro.org>
 <3e801cbef0a46d5c4f82d46debd3a72811becd4c.1627627021.git.viresh.kumar@linaro.org>
 <87lf5ey30z.fsf@redhat.com> <20210809041544.272ykb6mtg2xpucj@vireshk-i7>
Date: Mon, 09 Aug 2021 07:50:50 +0200
Message-ID: <87fsvjxj2d.fsf@redhat.com>
MIME-Version: 1.0
Subject: [virtio-dev] Re: [PATCH V8 1/2] virtio-gpio: Add the device specification
Content-Type: text/plain
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Arnd Bergmann <arnd@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski <bgolaszewski@baylibre.com>, Vincent Guittot <vincent.guittot@linaro.org>, Jean-Philippe Brucker <jean-philippe@linaro.org>, Bill Mills <bill.mills@linaro.org>, Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>, "Enrico Weigelt, metux IT
 consult" <info@metux.net>, virtio-dev@lists.oasis-open.org, Geert Uytterhoeven <geert@linux-m68k.org>, stratos-dev@op-lists.linaro.org, Thomas Gleixner <tglx@linutronix.de>, Marc Zyngier <maz@kernel.org>, Arnd Bergmann <arnd@arndb.de>
List-ID: <virtio-dev.lists.oasis-open.org>

On Mon, Aug 09 2021, Viresh Kumar <viresh.kumar@linaro.org> wrote:

> On 06-08-21, 18:02, Cornelia Huck wrote:
>> On Fri, Jul 30 2021, Viresh Kumar <viresh.kumar@linaro.org> wrote:
>> > +\subsection{Device Initialization}\label{sec:Device Types / GPIO Device / Device Initialization}
>> > +
>> > +\begin{itemize}
>> > +\item The driver MUST configure and initialize the \field{requestq} virtqueue.
>> 
>> Also outside of conformance sections. Maybe "The driver configures and
>> initializes..." ? I don't think that one requires a normative statement.
>
> Not sure I understood it well, but are you suggesting to drop this line
> altogether ? I wrote it as I saw similar lines/sections for other protocols, I
> can drop it though.

No, just rewrite it as an informational text (i.e. get rid of the
'MUST', which only belongs into normative statements.)


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

