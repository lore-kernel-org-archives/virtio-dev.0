Return-Path: virtio-comment-return-1170-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
References: <20200327103803.10460-1-alex.bennee@linaro.org>
 <20200327115338.57a79ac4.cohuck@redhat.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20200327115338.57a79ac4.cohuck@redhat.com>
Date: Fri, 27 Mar 2020 11:58:02 +0000
Message-ID: <87pncym2lx.fsf@linaro.org>
MIME-Version: 1.0
Subject: Re: [virtio-comment] [RFC PATCH  0/8] some tweaks to the document
 build process
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
To: Cornelia Huck <cohuck@redhat.com>
Cc: virtio-dev@lists.oasis-open.org, virtio-comment@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>


Cornelia Huck <cohuck@redhat.com> writes:

> On Fri, 27 Mar 2020 10:37:55 +0000
> Alex Benn=C3=A9e <alex.bennee@linaro.org> wrote:
>
>> Hi,
>>=20
>> I was reviewing someones virtio-spec and realised that I wasn't quite
>> sure what it had been built from. Seeing as the standard is hosted in
>> git I've tried to clean up some of the automation to make it clearer
>> what a particular rendering was built from. Going forward it would be
>> nice to use signed annotated tags for the final build version but I
>> don't know how much of the boilerplate is down to OASIS requirements.
>
> OASIS requirements are my concern here as well.

I've tried to do some digging although the Oasis website has a lot of
policy documents. I think the most relevant one is:

  https://docs.oasis-open.org/specGuidelines/ndr/namingDirectives.html

which as far as I can make out is mostly concerned that the final work
product meets the naming standard by version and stage. Although ZIP
files are mentioned a couple of times it is in the context of a file
containing work products for local use. My personal interpretation is
that if the final work products are correctly named and have the version
information in them the rest is just ephemera. However I could be wrong
so defer to anyone more familiar with the policies.

An random sampling of ZIP files on https://www.oasis-open.org/standards
has shown them all to just contain the individual work products without
any extraneous REVISION/REVISION-DATE files.

Anyway I defer to those with more experience of the process and I'll
leave the question of tex vs rst for another day ;-)

--=20
Alex Benn=C3=A9e

This publicly archived list offers a means to provide input to the=0D
OASIS Virtual I/O Device (VIRTIO) TC.=0D
=0D
In order to verify user consent to the Feedback License terms and=0D
to minimize spam in the list archive, subscription is required=0D
before posting.=0D
=0D
Subscribe: virtio-comment-subscribe@lists.oasis-open.org=0D
Unsubscribe: virtio-comment-unsubscribe@lists.oasis-open.org=0D
List help: virtio-comment-help@lists.oasis-open.org=0D
List archive: https://lists.oasis-open.org/archives/virtio-comment/=0D
Feedback License: https://www.oasis-open.org/who/ipr/feedback_license.pdf=
=0D
List Guidelines: https://www.oasis-open.org/policies-guidelines/mailing-lis=
ts=0D
Committee: https://www.oasis-open.org/committees/virtio/=0D
Join OASIS: https://www.oasis-open.org/join/

