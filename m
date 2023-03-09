Return-Path: <virtio-dev-return-11574-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD839C742A7
	for <virtio-dev@archiver.kernel.org>; Thu,  9 Mar 2023 14:12:01 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id E0A6B3E306
	for <virtio-dev@archiver.kernel.org>; Thu,  9 Mar 2023 14:12:00 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id DB2E898671C
	for <virtio-dev@archiver.kernel.org>; Thu,  9 Mar 2023 14:12:00 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id CFEE39866F6; Thu,  9 Mar 2023 14:12:00 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id BD5C59866F7;
	Thu,  9 Mar 2023 14:11:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=APd8RH+SE/F1+xXe3bftd0SIXkkq2NhzsItE+/jyUhZVLoI47I/ZA26NppZkFfsShIx0oBK9PhCbHMYt5PrZZXuyV4HP+ei20b/9QVRRgjm+jaEJRS1MQEKvrYFuf3X7zP2xzZzSuorzFhBvjpeaA6uKKBf3ru2CNCm9nUMIXD3MXyng4JDUpOP1bUMUIlKcr++9fWPFmMZbwuOCx0LJe8yxVxFBgg5+1q6Xtc5GAMaZZS9tDfVLh9Cvil8iucRleGvSNgOVoUa5LiNb06Z+4KrtUxaobsxkIuvENnAn+xip+96CDKig6Jgj7og542hISVaBeYbUIEou7oVvbkBtHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KNAQMte3akv28wcUeX2TOnkeUGgt5wI+5LXXEWa2njk=;
 b=T9j9FhB9qeUvfKibU1FLkIc3XTX8qrIwAZvth/4rdbEOaw1reGM5Lmms3la85WTcWT4wYDACbPnMfzfo/0wo3NJSGnb5OrtN4UmemZA6y0cM4A4TPMgwewm9lblrvMW9ApvlVDY5jISLj1JqHO7XHTDxFlAu21AYu85ghhsCDNWB9TGHRTPBapc6GUM5CmglTjGUbwta27v83Vkz4od0y8G/IkeslOrme/4CMXe9+XVgJJWS/F5WgsaGIdTyzTJizak6PBE35SsZ0FGM8kjpkkLr91xp95SgoBom+TxCPWX/spcUkXWzKxgFNemViUPw291zA7B9FUL1FopB7lzHZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: David Edmondson <david.edmondson@oracle.com>, Jiri Pirko <jiri@nvidia.com>
CC: Max Gurtovoy <mgurtovoy@nvidia.com>, "Michael S. Tsirkin"
	<mst@redhat.com>, "virtio-comment@lists.oasis-open.org"
	<virtio-comment@lists.oasis-open.org>, "virtio-dev@lists.oasis-open.org"
	<virtio-dev@lists.oasis-open.org>, "jasowang@redhat.com"
	<jasowang@redhat.com>, "cohuck@redhat.com" <cohuck@redhat.com>,
	"sgarzare@redhat.com" <sgarzare@redhat.com>, "stefanha@redhat.com"
	<stefanha@redhat.com>, "nrupal.jani@intel.com" <nrupal.jani@intel.com>,
	"Piotr.Uminski@intel.com" <Piotr.Uminski@intel.com>, "hang.yuan@intel.com"
	<hang.yuan@intel.com>, "virtio@lists.oasis-open.org"
	<virtio@lists.oasis-open.org>, Zhu Lingshan <lingshan.zhu@intel.com>,
	"pasic@linux.ibm.com" <pasic@linux.ibm.com>, Shahaf Shuler
	<shahafs@nvidia.com>
Thread-Topic: [virtio-comment] Re: [virtio] [PATCH v10 04/10] admin: introduce
 virtio admin virtqueues
Thread-Index:
 AQHZUaV1hq+swD5r7EeFCHM9rP6wha7wxScAgAAFDACAAFmxgIAACLQAgAA3RYCAAKrygIAAXFnAgAARIACAAACcoA==
Date: Thu, 9 Mar 2023 14:11:54 +0000
Message-ID:
 <PH0PR12MB5481FD2D2365CC08A5CD1E64DCB59@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <ZAXfegxCfvfLwiJT@nanopsycho>
 <20230306133816-mutt-send-email-mst@kernel.org> <ZAbpiRVdo8BciELX@nanopsycho>
 <20230307111458-mutt-send-email-mst@kernel.org> <ZAhdzCd6qwWydesz@nanopsycho>
 <20230308064505-mutt-send-email-mst@kernel.org> <ZAh61E/wQ/hSY/OI@nanopsycho>
 <18d51bc0-d759-1a05-cb7c-3d46c4ed2f1a@nvidia.com> <m2wn3rxgv5.fsf@oracle.com>
 <PH0PR12MB548150700B50006F9F174104DCB49@PH0PR12MB5481.namprd12.prod.outlook.com>
 <ZAmLIc97Ud09YfGT@nanopsycho>
 <PH0PR12MB54817E2CEFF003E793C9B2F3DCB59@PH0PR12MB5481.namprd12.prod.outlook.com>
 <m2mt4mxbt5.fsf@oracle.com>
In-Reply-To: <m2mt4mxbt5.fsf@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|CH3PR12MB8481:EE_
x-ms-office365-filtering-correlation-id: 4995fc63-35ad-487f-0230-08db20a83c5f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 Oagbkuz5UfOWtgARuZHgaJ9cd//S4Img5neaKC3I20A//cRLC1MtIbccOOSj700p8HMSKXX2eCgzikzXIJZK63P1Faf41vRS7eJpPld/noj5I15AdOqtz7PbqXN9yHt+L52wNZUElMXdumrtQLpb65dyl0auzjBkb6FwHXbmWK1UoZZ03vDpqq+vlpM/0ooK3vzt2xuBksH2nBPFQtbz4cWXsRUY67mIca1wef1f+rlwf6WfzOVc3s2bKgmeQsjrriSSOJ8dIVlW6tSY6PZsJuquc7AI2UVEFk0dyHqjYEYiQb4gauv8nwYNRGL8+B5Vqdzi9jP9n0C7MXX69H8bjE6gr9eh5RtaRHjUcmrWJKfCD00iD8Ud+tA3prrwYNaNe3ZlASC6thFYON50k7LyeCkUnnRliPLc3AhYzHSEkw98ryN27jkD0RJ672Z151pSJu4wSvktH9uU7u7ashN0f1/vI0HLxTsBDWcrL5rTIx433YxKiI2K6TYQkShdMrApIvvBuQXzXilrhDE+mbjI+Bil1AtYw8EqsiUQedpU92RABzh/8/yDzA6pUTTwqmwAv51j1+o2lL7fxWZzkR/X5ZNsoGdde/KHo76JNU0//DKSexYZTTjmUbtm9L4y1iUbeCTJhq6PalMS22yM4oJHXnATDlR2gdjsNDsXP4NmlZAbGv5EbcW7egiQW0O0EKuJAEVMDY5xgDgVS8k50K+/AA==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(136003)(396003)(39860400002)(376002)(346002)(451199018)(9686003)(186003)(38100700002)(2906002)(38070700005)(122000001)(6506007)(5660300002)(107886003)(7416002)(52536014)(8936002)(41300700001)(66476007)(110136005)(33656002)(86362001)(66946007)(66556008)(66446008)(8676002)(55016003)(4326008)(64756008)(76116006)(71200400001)(478600001)(316002)(7696005)(83380400001)(54906003)(6636002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?OvdVOslLV+twjy1Hxaro9TZkMmWhqmubbrmSAZ5vz9jA91bCQYLxA+DZ2RXH?=
 =?us-ascii?Q?6l4UTw5odJdSp8Y4vuBvPhv8GfmDZs6U2kPNmdiuFXLndTw9mfHAOYne93s0?=
 =?us-ascii?Q?xWK0QPLX9y+5VuzNQTs07nez5INQDulZ5MeA7ECi0X3bE957bP+bJgdjItqX?=
 =?us-ascii?Q?lEOoOLBrHQWjDe/V8THD8FFYFvRpXmMZAlu8KKOaqO0cvDHxAHYB/gxxKkev?=
 =?us-ascii?Q?1GW1AcjGtr7ky8STjmRwOiHdeIONtel/Uefs4jVGt3UmnDhDY7ZYf/opD6qS?=
 =?us-ascii?Q?oXVSVyHiFEGktsR0DJsWDMkml6KnDYZTfKC33Co0jHFXs7X8T2lBjjrey8kH?=
 =?us-ascii?Q?lHtg2aZ+Hr3f2nqgEVH+NU6wwBim0mncNgPZHWYZzVHAcreHq+qvKgAg1rd7?=
 =?us-ascii?Q?AmBC+N+0EvgHW/hH74rtTzPtCbJ8b1GPxn9qEa9HntXbpyGuhq12Yvy3yh0x?=
 =?us-ascii?Q?QZslXmotLwsxOwggFhJDu3WVuAPsWW+IuftvBHxqdaRRtTYwRrY0F8u6J43O?=
 =?us-ascii?Q?fCP9f0EK/ZIlw6jhpaG1AqUVrpOa+xni+oTT/tmtqhpl8ContEZh9+h4T+iX?=
 =?us-ascii?Q?0zZVdOfBajdkLDi89kS79ob0VqpWHAyjn6diOwt6uHvVzgBJDZ7uSxMSK9mm?=
 =?us-ascii?Q?9fGbMGXRN1VQLewEX2KzOeYe/smvNI+BiVFYfDqMVLZUKb8xPXem+ltbfhPA?=
 =?us-ascii?Q?2XquS9fRYNu1qXQBhAM9WqKO852ZQjqrTT5fK+ijmugf0JT3sWoLSdsKf818?=
 =?us-ascii?Q?zyfkUeuuJR1aHeyPU93rz0jCaOHGU+B6CnYo0/OgX6WBFXB2FbvZPdx68dtI?=
 =?us-ascii?Q?f0WC8dqzJ+gEYnnRSJSiKGH5DhNQIbjWM9hUdKOc+fbLRshR92JEEdvgMCrS?=
 =?us-ascii?Q?yDCHh5MHyJ8onMLRK36vg4zfe39jP2wmOEgfRTVwdi2AvtTCDhe+uLEyoStL?=
 =?us-ascii?Q?RNcALp9QMrpGOL7NdUyUkAaJE9PwDaynMUHAhT3xKUiLwMIEcn4m29iE37D2?=
 =?us-ascii?Q?CBMpMC5vQNSI41kU6R78dkos2tPHtAY270EqzMizcbbYG0Lt7MlIN2wkOOiE?=
 =?us-ascii?Q?XPDA1CFi/Cam0V+pBp1QMbKtMNXfrVS7p7lh6KxDrfXu0q48OK0Pcyz/cSjv?=
 =?us-ascii?Q?G2hSRu4v8/yFf20lJGqv6vTS1hMQegnNON6NfPDL8XT9GIei0C2kYq70Hl3G?=
 =?us-ascii?Q?WtYfBz4Ixo6SqZfOny6krLpoxOT03J5zDyU9BCiuOwKkYPDxkcCuhgG/hDWj?=
 =?us-ascii?Q?wtIKlI5hXPsFF8TvEugtRMrz2R+d1XVju0KnWhpMv4XncMIyNdJ6qN/v6og9?=
 =?us-ascii?Q?3RxI233zYo8+Wl7nYbaS7u1xkBugxu0naBhWiGwdKHBnXpNA3xzoJjElf4Gp?=
 =?us-ascii?Q?+JpcT/e/iKTUCaUAAYrwsHl6V77YMA74IUjGW69RsrV5KQln7GvIhw8oJZOB?=
 =?us-ascii?Q?tLUQ4GDZXpEeQYig32PO69siI8ZM5nJKaGXn3xcABYdQMNPLNCM2wk9yFM7D?=
 =?us-ascii?Q?yWGoKBvNsWI7tUym74bZQO0BNl+tpeQo2e5bOCxWus/rTSg69JWNEoGay9Sg?=
 =?us-ascii?Q?0PqlYr8KPzmAVb9nLqF/+Zkhej1yC7eQy6zGcLwFfzCH4eCd6Ch5C+78Wfzw?=
 =?us-ascii?Q?eEh3sYMCWV174hFywYUCD4I=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4995fc63-35ad-487f-0230-08db20a83c5f
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Mar 2023 14:11:54.1886
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VJwCFCp2bhjeclja5nNMZDeuw3W0kBqIVsFiAYNsKJmCn7GgX6ojSrlaiqsTyVLWibGecrLUBZBEhRrLufPd3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8481
Subject: [virtio-dev] RE: [virtio-comment] Re: [virtio] [PATCH v10 04/10] admin: introduce
 virtio admin virtqueues



> From: David Edmondson <david.edmondson@oracle.com>
> Sent: Thursday, March 9, 2023 9:03 AM
>=20
> Parav Pandit <parav@nvidia.com> writes:
>=20
> >> From: Jiri Pirko <jiri@nvidia.com>
> >> Sent: Thursday, March 9, 2023 2:31 AM
> >>
> >> Wed, Mar 08, 2023 at 10:25:32PM CET, parav@nvidia.com wrote:
> >> >
> >> >> From: virtio-comment@lists.oasis-open.org
> >> >> <virtio-comment@lists.oasis- open.org> On Behalf Of David
> >> >> Edmondson
> >> >
> >> >> In support of live migration, might we end up moving large amounts
> >> >> of device state through the admin queue?
> >> >>
> >> >Correct.
> >> >
> >> >> If so, that would seem to have some performance requirements,
> >> >> though I don't know if it would justify multiple admin queues.
> >> >DMA of the data through the proposed AQ is supported.
> >> >
> >> >If I understood Max correctly when Max said " This AQ is not aimed
> >> >for performance ", he means that AQ doesn't have performance
> >> >requirements as
> >> io/network queues to complete millions of ops/sec.
> >> >
> >> >it is several hundred to maybe (on the higher side) thousand ops/sec
> >> >during
> >> LM, provisioning use case.
> >>
> >> But isn't it good to design it for performance from start? I mean,
> >> state transfer of thousands of VFs at a time is definitelly performanc=
e
> related, isn't it?
> >>
> > It is. Which part of the proposed AQ doesn't cover this aspect?
> > The only issue that I see today is, that a given GET family of commands=
 q
> contains the read-only and write-only descriptors which require multiple =
dma
> allocations on driver side.
>=20
> I don't think that there is any assertion that the current proposal doesn=
't cover
> this.
>=20
> It was intended as an illustration to try and help determine whether mult=
iple
> AQs for a single device was a requirement given existing anticipated usag=
e, or
> a safeguard against potential future uses.

Got it.

So far my understanding is:
1. Single AQ is enough for currently cited use cases
2. Having the infrastructure to support multiple AQ is also good.
The extra cost of this infra is only one read-only field =3D aq count as Mi=
chael proposed.

3. Ability to send multiple outstanding commands and execute them out of or=
der by device is/should be supported as long as IN_ORDER is not negotiated.
Should it be relaxed for AQ that even if IN_ORDER is negotiated, AQ by defa=
ult can be out of order queue?

4. Driver is the sole owner to decide if it is modifying an object through =
AQ, it should synchronize with ongoing AQ command on the same object or not=
.
5. If the command gets stuck for a very long time, the driver can recover t=
he AQ using the existing Q RESET facility.

Do we agree with the above design thoughts?
Or there is a better design than this discussed, and I missed it?



---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

