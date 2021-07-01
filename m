Return-Path: <virtio-comment-return-1924-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
References: <20210630115837.12182-1-info@metux.net>
 <20210630152213.xhqhke54gzt3esdj@vireshk-i7>
 <641254c3-d60d-eb17-7388-29dd9ebcb826@metux.net>
 <20210630173022.7ukqg764z5xi5uho@vireshk-i7>
 <CAK8P3a05SFQ2Vo_CjoC4kaxfz0jwj_K9ogfLw00rRim9EMZtnQ@mail.gmail.com>
From: "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Message-ID: <d4862fc4-97aa-a1a3-ef21-8c18cc3681b4@metux.net>
Date: Thu, 1 Jul 2021 16:43:04 +0200
MIME-Version: 1.0
In-Reply-To: <CAK8P3a05SFQ2Vo_CjoC4kaxfz0jwj_K9ogfLw00rRim9EMZtnQ@mail.gmail.com>
Subject: [virtio-comment] Re: [virtio-dev] Re: [virtio-comment] [PATCH v2] virtio-gpio: add
 formal specification
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: tl
Content-Transfer-Encoding: quoted-printable
To: Arnd Bergmann <arnd@linaro.org>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org, Vincent Guittot <vincent.guittot@linaro.org>, Bill Mills <bill.mills@linaro.org>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Bartosz Golaszewski <bgolaszewski@baylibre.com>, Linus Walleij <linus.walleij@linaro.org>, Jason Wang <jasowang@redhat.com>, Jean-Philippe Brucker <jean-philippe@linaro.org>, Geert Uytterhoeven <geert@linux-m68k.org>
List-ID: <virtio-dev.lists.oasis-open.org>

On 01.07.21 11:01, Arnd Bergmann wrote:

> Agreed, interrupt support is obviously something that can not be
> retrofitted easily if you don't get it right from the start.

It's basically present, the basic version (as now writting in this spec)
just can't do hardware masking - that part is planned as an optional
feature (which I haven't yet put into that spec version, since I wanted
to get the basic version finished up before doing the optional
features).

Actually, the optional feature will just add another message for
mask/unmask. I'll yet having conversations w/ HW engineers on certain
aspects, e.g. automatic masking (yes/no/configurable ?).

There're also other more sophisticated features like HW debounce,
pinmux, etc, that are to come later - as *optional* features that some
device may or may not support.

Note that this isn't just about moving drivers into some VMM, but also
about actual hardware.


--mtx

--=20
---
Hinweis: unverschl=C3=BCsselte E-Mails k=C3=B6nnen leicht abgeh=C3=B6rt und=
 manipuliert
werden ! F=C3=BCr eine vertrauliche Kommunikation senden Sie bitte ihren
GPG/PGP-Schl=C3=BCssel zu.
---
Enrico Weigelt, metux IT consult
Free software and Linux embedded engineering
info@metux.net -- +49-151-27565287

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
List Guidelines: https://www.oasis-open.org/policies-guidelines/mailing-lis=
ts
Committee: https://www.oasis-open.org/committees/virtio/
Join OASIS: https://www.oasis-open.org/join/

