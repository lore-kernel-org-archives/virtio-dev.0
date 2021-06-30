Return-Path: <virtio-comment-return-1915-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
Date: Wed, 30 Jun 2021 09:28:16 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
Message-ID: <20210630035816.4chjlo5la4d2hphp@vireshk-i7>
References: <20210617094122.1627-1-info@metux.net>
 <20210617094122.1627-2-info@metux.net>
 <20210617113310.6oo74e5htvmm4afr@vireshk-i7>
MIME-Version: 1.0
In-Reply-To: <20210617113310.6oo74e5htvmm4afr@vireshk-i7>
Subject: [virtio-comment] Re: [virtio-dev] [PATCH] virtio-gpio: add formal specification
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: "Enrico Weigelt, metux IT consult" <info@metux.net>
Cc: virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org, Vincent Guittot <vincent.guittot@linaro.org>, Bill Mills <bill.mills@linaro.org>, Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>, Bartosz Golaszewski <bgolaszewski@baylibre.com>, Linus Walleij <linus.walleij@linaro.org>, Jason Wang <jasowang@redhat.com>, Jean-Philippe Brucker <jean-philippe@linaro.org>, Arnd Bergmann <arnd@linaro.org>, Geert Uytterhoeven <geert@linux-m68k.org>
List-ID: <virtio-dev.lists.oasis-open.org>

On 17-06-21, 17:03, Viresh Kumar wrote:
> + couple of folks who have shown interest in this stuff.
> 
> On 17-06-21, 11:41, Enrico Weigelt, metux IT consult wrote:
> > This patch adds specification for attaching general purpose IO (gpio) devices
> > via virtio. The protocol is specifically designed to be easily implemented in
> > software (e.g. hypervisors) as well as low end hardware (eg. silicon, FPGA,
> > tiny MCUs) and allows future extensions while retaining full backwards
> > compatibility.

Hi Enrico,

It has been two weeks since the previous post, since no one else
replied yet, I think it is good time now for the next version to be
posted. :)

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

