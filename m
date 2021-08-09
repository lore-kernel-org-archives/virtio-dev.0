Return-Path: <viresh.kumar@linaro.org>
Date: Mon, 9 Aug 2021 09:45:44 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V8 1/2] virtio-gpio: Add the device specification
Message-ID: <20210809041544.272ykb6mtg2xpucj@vireshk-i7>
References: <cover.1627627021.git.viresh.kumar@linaro.org>
 <3e801cbef0a46d5c4f82d46debd3a72811becd4c.1627627021.git.viresh.kumar@linaro.org>
 <87lf5ey30z.fsf@redhat.com>
MIME-Version: 1.0
In-Reply-To: <87lf5ey30z.fsf@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: Cornelia Huck <cohuck@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Arnd Bergmann <arnd@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski <bgolaszewski@baylibre.com>, Vincent Guittot <vincent.guittot@linaro.org>, Jean-Philippe Brucker <jean-philippe@linaro.org>, Bill Mills <bill.mills@linaro.org>, Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>, "Enrico Weigelt, metux IT consult" <info@metux.net>, virtio-dev@lists.oasis-open.org, Geert Uytterhoeven <geert@linux-m68k.org>, stratos-dev@op-lists.linaro.org, Thomas Gleixner <tglx@linutronix.de>, Marc Zyngier <maz@kernel.org>, Arnd Bergmann <arnd@arndb.de>
List-ID: <virtio-dev.lists.oasis-open.org>

On 06-08-21, 18:02, Cornelia Huck wrote:
> On Fri, Jul 30 2021, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> > +\subsection{Device Initialization}\label{sec:Device Types / GPIO Device / Device Initialization}
> > +
> > +\begin{itemize}
> > +\item The driver MUST configure and initialize the \field{requestq} virtqueue.
> 
> Also outside of conformance sections. Maybe "The driver configures and
> initializes..." ? I don't think that one requires a normative statement.

Not sure I understood it well, but are you suggesting to drop this line
altogether ? I wrote it as I saw similar lines/sections for other protocols, I
can drop it though.

-- 
viresh

