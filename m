Return-Path: virtio-comment-return-1908-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
Date: Fri, 18 Jun 2021 16:50:52 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
Message-ID: <20210618112052.bysosqxnjllj3f3o@vireshk-i7>
References: <20210617094122.1627-1-info@metux.net>
 <20210617094122.1627-2-info@metux.net>
 <20210617113310.6oo74e5htvmm4afr@vireshk-i7>
 <c652943a-16b9-3246-460d-40896abc6f8c@metux.net>
MIME-Version: 1.0
In-Reply-To: <c652943a-16b9-3246-460d-40896abc6f8c@metux.net>
Subject: Re: [virtio-comment] Re: [virtio-dev] [PATCH] virtio-gpio: add
 formal specification
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Cc: "Enrico Weigelt, metux IT consult" <info@metux.net>, virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org, Vincent Guittot <vincent.guittot@linaro.org>, Bill Mills <bill.mills@linaro.org>, Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>, Bartosz Golaszewski <bgolaszewski@baylibre.com>, Linus Walleij <linus.walleij@linaro.org>, Jason Wang <jasowang@redhat.com>, Jean-Philippe Brucker <jean-philippe@linaro.org>, Arnd Bergmann <arnd@linaro.org>, Geert Uytterhoeven <geert@linux-m68k.org>
List-ID: <virtio-dev.lists.oasis-open.org>

On 18-06-21, 11:19, Enrico Weigelt, metux IT consult wrote:
> On 17.06.21 13:33, Viresh Kumar wrote:
> 
> > FWIW ./makehtml.sh reported a few missing references I believe, it
> > wasn't a clean build.
> 
> I'm seeing those (also w/ makepdf.sh) even in master.

I don't see errors in master (build doesn't stop), but with your patch. With
makehtml build stops in between and I have to hit enter to let it continue. And
there are missing references from GPIO itself I think.

I haven't tried makepdf though, it looks different in that sense to me.

> Since they only
> appear pretty early, while the script does several xetex runs, I'd
> suspect that's the usual tex behaviour:
> 
> When using xrefs, you have to do multiple runs, since it's working
> linear and doesn't know the targets in the first runs. But it writes
> the targets it encounters in a temporary file which is loaded in
> subsequent runs - then the xrefs can be resolved and the warning goes
> away. Same when using toc / index / bibliography.

Try makehtml, you will see the GPIO ones.

> >> +\begin{tabular}{|l|l|l|}
> >> +    \hline
> >> +    \textbf{Offset} & \textbf{Type} & \textbf{Description} \\
> >> +    \hline
> >> +    0x00   & u8           & version \\
> > 
> > As previously mentioned by Jason as well, most of the virtio protocol
> > specifications don't talk about versions but rather Features. The
> > features are normally more readable than saying version is 1.0 or 2.0.
> 
> Right, but these are separate things. I believe that most future
> extensions can be done by feature bits. But it seems good to have
> something in reserve in case that isn't enough some day - otherwise
> we'd have to allocate a new ID for that.

If that day occurs, we will reserve a feature bit for version and a field in
config structure for the same. There is no need of it right now and it shouldn't
be there.

> Finally it's just one byte in a ROM :p

It doesn't really matter, this is not required. Virtio takes care of such stuff
with features and so should we.

> > I understand from our previous discussions that you wanted to make it
> > possible for this structure to be extended in the future and so kept
> > the extra padding of 24 bytes. That is a right thing to do, as we may
> > need to add more fields here.
> 
> I see two options:
> a) add some reserve space (but with unpredictable readout data)
> b) increase the size in future versions
> 
> I'll have to check back w/ my HW folks whether an reserved but
> unassigned address space adds a notable amount of gates. There might
> be some special handling necessary, since we don't wanna end up in
> faults when a fully valid driver reads out more rom space than the
> device actually has.
> 
> > Having said that, the only thing which limits this structure to be
> > extended in future is the "line names block", simply because we don't
> > know the size of it in advance and we need to keep it at the end for
> > the same reason.
> 
> We have it's size, so the driver can calculate it (the likehood that
> driver is done by some - even little - cpu is much higher than on the
> device side). So, the next block would start right after that.
> 
> > A better approach for that, as Jean Philippe suggested earlier, is to
> > rather add a new field, "gpio names offset", which will convey the
> > offset of the names block from the beginning of the structure. In your
> > case you can keep it to 0x40, while others can avoid the rather
> > unnecessary padding.
> 
> Okay, but we'd still need the size field.

Oh yes, you need size as well as offset. With these two, we can actually add
another such block after names block, in future if the need arises.

> > What is CPU here? Driver/Guest ? I wonder if it would be better if we
> > talk in terms of Virtio spec standards here, which are "device" and
> > "driver".
> 
> Right, should be called "driver". Seems some of the terminology things
> slipped through.
>
> >> +\subsubsection{Message types}\label{sec:Device Types / General Purpose IO / Virtqueues / Message types}
> >> +
> >> +\begin{tabular}{|l|ll|}
> >> +    \hline
> >> +    \textbf{Code} & \textbf{Symbol} & \\
> >> +    \hline
> >> +    0x0001        & VIRTIO_GPIO_MSG_CPU_REQUEST            & request gpio line           \\
> > 
> > This requires a corresponding "FREE" Msg type as well. This is already
> > well implemented and accepted in Linux kernel as well.
> 
> Okay, lets add it.
> 
> >> +    0x0002        & VIRTIO_GPIO_MSG_CPU_DIRECTION_INPUT    & set direction to input      \\
> >> +    0x0003        & VIRTIO_GPIO_MSG_CPU_DIRECTION_OUTPUT   & set direction to output     \\
> >> +    0x0004        & VIRTIO_GPIO_MSG_CPU_GET_DIRECTION      & read current direction      \\
> >> +    0x0005        & VIRTIO_GPIO_MSG_CPU_GET_LEVEL          & read current level          \\
> >> +    0x0006        & VIRTIO_GPIO_MSG_CPU_SET_LEVEL          & set current (out) level     \\
> > 
> > These look good.
> > 
> >> +    0x0011        & VIRTIO_GPIO_MSG_DEVICE_LEVEL           & level changed (device->CPU) \\
> > 
> > I believe this is the interrupt from Device to Driver ? I believe it
> > would be more readable if it can be called as an interrupt.
> 
> Well, you could call it interrupt, sort of. Actually it's a level state
> change notification - pure IRQ wouldn't necessarily carry the extra
> data. For an HW engineer, an IRQ usually would be essentially one edge,
> and one has to look very closely to find out what some particular edge
> is actually meaning. IRQs usually just tell that *something* happened,
> but you'll need extra steps (e.g. read out some registers) to find out
> what actually did happen.

Right, that is why the driver first needs to configure a particular GPIO line
for a particular IRQ type, like edge (falling/rising) or level, so it doesn't
need to get additional information. The irq came exactly for how it is
programmed to come.

> In this case, the DEVICE_LEVEL message is on a much higher level than a
> plain IRQ, it also carries the information what exactly happened.
> 
> I'd say let the TC folks decide on the appropriate terminology.
> 
> > I do not see a way for masking/unmasking interrupts right now, we need
> > them right now. 
> 
> That's correct and intended. The problem is this needs extra logic on
> the device for an interrupt controller, so I would hate to make it
> mandatory for all. Not all gpio-controllers have such logic. On many
> SoCs the gpio-controller has only *one* global IRQ line routed to some
> IRQ controller somewhere else in the SOC. It depends on the actual setup
> how we learn what actually happens. On Linux, when an gpio-consumer gets
> a notification on some particular pin, a lot of (highly hw specific)
> things already happened (eg. reading out several IRQ controllers to
> follow the IRQ chain and finally reading the gpio line states from the
> gpio-controller, possibly comparing w/ the last known state in order
> to detect the edge direction, etc). Oh, and it even gets more complex:
> some IRQ controllers automatically mask when IRQ is fired and need
> explicit ack, some don't ... phuh.
> 
> Not trivial at all to find a good common ground for all scenarios as
> well as minimal hardware requirements. That really needs some much
> deeper thoughts to get it really right. Needs more discussions with
> HW engineers.
> 
> You're certainly right that, at some point, we should have that. But it
> really should be optional, so that actual silicon isn't required to have
> its own IRQ controller.

I think we have already found a way for making it optional, using feature bit
i.e.. What's new now ?

> > I am fine with adding other request types, like
> > debounce, etc, later on, but interrupt support is bare minimum for us.
> 
> Do you have such a high load or extreme low-power requirements that you
> cannot live without irq masking, until we have it as an optional feature
> extension ? What HW are you using for the driver side ?

As I said earlier, I am looking for a generic interface for GPIO protocol and
irq support is bare minimum. I am not asking to force it to everyone, but make
it optional and keep it for the people who want it.

> > These are the new request types we would need for that, unless there
> > are more:
> > 
> > IRQ_TYPE	IRQ_MASK	IRQ_UNMASK
> 
> With the mask it's getting interesting. Note we're (theoretically)
> supporting 2^16 lines (real implementations probably stay much below
> that), so we'd need enough room for that.

Yeah, so the hardware (FPGA I think which you are working on) shouldn't need to
implement this. They will just not provide the associated feature bit.

> Maybe we should do it individually per line. This causes more traffic
> at setup, but also has the positive side effect that driver can easily
> mask/unmask invidual lines without remembering the mask.

Yeah, this is very much expected out of any basic GPIO controller or a spec for
the same.

> > And these are the interrupt types we need to support, for now. Again
> > they are quite standard if you look at Linux's GPIO support.
> > 
> > IRQ_TYPE_NONE	
> > IRQ_TYPE_EDGE_RISING
> > IRQ_TYPE_EDGE_FALLING	
> > IRQ_TYPE_EDGE_BOTH	
> > IRQ_TYPE_LEVEL_HIGH	
> > IRQ_TYPE_LEVEL_LOW
> 
> Well, "quite standard" is only when looking at what Linux gpio-subsys
> supports. That doesn't mean that actual HW supports it directly. When
> we make all these variants mandatory, we force a huge increase of the
> hardware size (number of gates, chip size, power consumption).
> 
> We should be very careful in our decisions.
> 
> Note: I'm not doing this just for some host to vm signaling, but also
> for actual hardware - embedded hardware. My goal also is laying out the
> basis so this could become a standard interface even on-chip gpio-
> controllers.

In such scenarios, the hardware doesn't need to implement these. You can just
fail such requests then or best don't even add the feature for your hardware.

Note that the same will happen for the requests Linus talked about during the
previous reviews, the list is present in
include/linux/pinctrl/pinconf-generic.h.

> >> +    \item requests are processed and replied in the they had been sent
> > 
> > in the *order* they...
> 
> fixed.
> 
> > Why is this important really ? If there are constraints in the control
> > flow (i.e. operation 1 must happen before operation 2), then the
> > request initiator needs to make sure of that. 
> 
> The ordering is for associating request + reply. Otherwise we'd need
> to add some kind of request identification (eq. seq numbers).

Yeah I thought about that earlier, but with the same layout for request/response
messages that you have chosen, it makes our life easy. The gpio pin number in
the request/response makes it work for us. We can use the gpio number as the
sequence number here.

> I don't
> see any good reason why some HW shouldn't keep the order inherently,
> but it's probably better to leave no room for diferent interpretations
> here.

This is a limitation, which isn't really required. It only adds restrictions,
which not everyone wants.

In your case you can just send the responses in FCFS form, while others can do
it the way they want, handle responses to come asynchronously.

> > Otherwise, it doesn't
> > matter which one finishes first. The response message will have the
> > GPIO number in it and so the initiator will know whose response it is.
> 
> That's correct. At least for the currently defined operations, which
> always have pin number. Who knows what the future will bring, so IMHO
> it's better to care about that (even just hypothetical) issue now,
> instead of running into trouble some time later.
> 
> Do you have any reason for NOT having this constraint.

Firstly, you need a _strong_ reason for adding a constraint and not vice versa,
we just can't add them hypothetically.

Secondly, It makes it less efficient.

Lets say device got Request A followed by Request B, but it was able to process
Request B faster than request A (which happens all the time with Linux because
of process scheduling and what not), then the device doesn't need to wait for a
response to request A before sending one for request B. There is no point in
that. Moreover it will increase the waiting time of another process at guest
(for request B), which may not anything to do with process attached with Request
A.

> > While on that, we must put a limit on number of messages started by
> > one side for the same GPIO line. i.e. Driver can not start another
> > operation for the same GPIO line, before receiving response for the
> > previous request for that GPIO line. Same goes for interrupts from
> > device to driver/CPU.
> 
> Queue size isn't enough for you ?

The queue is shared by all the GPIOs, lets say 256 of them. So I am not sure how
queue size works with it.

> Or do you want an explicit per-line limit ? Why do you feel its needed ?
> Is there anything that can go wrong with that ? Do you know any HW gpio
> controller that has such a limit ?
> 
> Certainly, it might not be practically useful to fire too many changes
> in a very short time,

Yes, so we don't normally start multiple requests for the same line. Any sane
code will always wait for the first operation to finish before the new one.

Like do a gpio-request, followed by get direction, and then set-direction or
something else. All of these are performed in sequence and the initiator will
always wait for the first request to finish before going for the second one.

Why would we ever want to send multiple instructions to the same line ?

> but could it cause any actual problem ?

I am not sure, because the software will always wait for the response to the
previous request for the same line. And we shall never have a case where two
requests for the same line come at the same time. Is there any such scenario
that I am missing ?

Moreover with interrupts, things become tricky. The device shall wait for the
first interrupt for a particular line to be finished, before sending another
one, else it can surely cause problems. Moreover, the kernel (on the guest side)
will try to mask the interrupt after receiving one, before sending the response
to the interrupt. So this kind of sequencing is actually better to have to avoid
deadlocks which may occur otherwise.

Linus thoughts ?

> >> +\begin{tabular}{ll}
> >> +    \hline
> >> +    \textbf{request:} & \\
> >> +    \hline
> >> +    \field{line}  field: & logical line number \\
> > 
> > s/logical/GPIO/ ?
> 
> if you insist, i'll change that ;-)

I don't insist for this TBH, but I wasn't sure if logical have a special meaning
here at all. We don't have virtual numbers for GPIOs and so logical ones also
don't make much sense.

> By the way: we've got a lot of repeated text here that calls for putting
> it into macros. Since it's a big document - do we have any constraints
> on the naming of such local macros ? I'm reluctant to doing dirty tricks
> with undefining commands :o

I am not sure, I would try to look at other documents inside virtio repository.

> >> +\begin{tabular}{ll}

On the same lines, your current document looks different than other protocols in
the spec right now. The spec maintainers may object to that and it may be better
to keep similar formats for such stuff. Like other protocols don't use tables
much but different section types for code like stuff.

Anyway, not my domain :)

> >> +    \hline
> >> +    \textbf{request:} & \\
> >> +    \hline
> >> +    \field{line}  field: & logical line number \\
> >> +    \field{value} field: & line level (0=inactive, 1=active) \\
> >> +    \hline
> >> +    \textbf{reply:} & \\
> >> +    \hline
> >> +    \field{value} field: & new line level or (negative) POSIX errno code \\
> > 
> > Why not 0 for success? How will the driver use the returned value here ?
> 
> The idea was device doesn't need to touch this field if everything's
> fine.

I think it is better for clarity to have response 0 for all success messages,
otherwise this will rather add special handling in code. I can see on the guest
Linux driver, a single function can take care of setting this field for all type
of response messages, but with current spec, we will require different handling
for 1 request.

> >> +\drivernormative{\subsubsection}{Data flow}{Device Types / General Purpose IO / Data flow}
> >> +
> >> +The driver MUST NOT send VIRTIO_GPIO_MSG_DEVICE_LEVEL and MUST NOT set the highest bit in the message type.
> > 
> > The device would need some kind of acknowledgement (as Linus also
> > asked earlier) for the interrupt from the driver, before which it is
> > eligible to send another interrupt for the same line.
> 
> No, this version does not have any kind of irq controller functionality.
> It just sends this message unconditionally.

It is interrupt, even if you don't want to call it one :)

> As already mentioned above, masking shall be an optional extra feature.
> 
> I'd suggest splitting the discussion into the basic functionality (that
> we already have now) and additional features like IRQ controller etc.

You can always skip implementing this for your hardware, but since we are
defining the spec now, we should implement all basic functionality (according to
different people). For you irq isn't basic, for me it is.

So lets make it optional but implement it right away :)

Thanks.

-- 
viresh

This publicly archived list offers a means to provide input to the
OASIS Virtual I/O Device (VIRTIO) TC.

In order to verify user consent to the Feedback License terms and
to minimize spam in the list archive, subscription is required
before posting.

Subscribe: virtio-comment-subscribe@lists.oasis-open.org
Unsubscribe: virtio-comment-unsubscribe@lists.oasis-open.org
List help: virtio-comment-help@lists.oasis-open.org
List archive: https://lists.oasis-open.org/archives/virtio-comment/
Feedback License: https://www.oasis-open.org/who/ipr/feedback_license.pdf
List Guidelines: https://www.oasis-open.org/policies-guidelines/mailing-lists
Committee: https://www.oasis-open.org/committees/virtio/
Join OASIS: https://www.oasis-open.org/join/

