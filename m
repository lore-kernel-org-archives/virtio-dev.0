Return-Path: <virtio-dev-return-13404-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1939FEB64DC
	for <virtio-dev@archiver.kernel.org>; Fri, 21 Jul 2023 14:21:22 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 7700577FD
	for <virtio-dev@archiver.kernel.org>; Fri, 21 Jul 2023 14:21:21 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 6FAA898684C
	for <virtio-dev@archiver.kernel.org>; Fri, 21 Jul 2023 14:21:21 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 61ABF986842; Fri, 21 Jul 2023 14:21:21 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 4BD2A986840;
	Fri, 21 Jul 2023 14:21:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HxvK+CUp/D+gRNWW3FFt/hIbak8TeFwXsURFZ2lqK61j5hF/HHHmWc0xG4NqrKYpZO5KEpA3OflfEn/+gbFfwUnGNUo7T/J6gDMBThZKjRS364K/JsUIcc2/ny50pIf1Yzk9G0YJnCb1syrFJnNxOn8p1eaNtfneox/GPHMvVMdJPlNXDF5WB+ovnJLdHWvSZ9OlkHcmXP18jPWyuSxTo1EE6LbXHMQ02d4hLhvjern2UeSRGCeMxhXPtfbF8jmQa3BrvLsYd5HZ2JlKzaLgoPexaM7SMYHT5MT1QPDQgOEoN+RjN5C2d4fQzMPfZyNjG0PrfZ5Zzb5iGC/8jZgBkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f+AU+EIhthTGpJNEtFLuGRm6kvb3EzfAVbIuzW3+FEQ=;
 b=IuEi0JztRm42vTfqLCLTczmLQAisbrmESaa6DM635xPOptgGligT5kkRaouO62VYxlfyXJnoeOmGDuLPU/DXtxlTqzPOi7jOq7Ka+grI3XQsxAG3zusRsU9J3S36iEMtrw/ScdFky753q+lTtlQ5X3563pd8CDytYGqtBQDBxkElmcPlfcgfxZoGLXwL7aywR0MOSO0cEhlbXFVDWqFYN3JXrjt+/scB1dyPMXpAWYciaj41OLKzDCaeFdgd1YWduT6RHUZpa8xi34l7Wd49DZWRuZza41n7poURN1P/jCRmuFoE7EIQPZFjpVIxyEyUc1oflpwHeA0i3d222yqDzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: Cornelia Huck <cohuck@redhat.com>, "virtio@lists.oasis-open.org"
	<virtio@lists.oasis-open.org>
CC: "virtio-comment@lists.oasis-open.org"
	<virtio-comment@lists.oasis-open.org>, "virtio-dev@lists.oasis-open.org"
	<virtio-dev@lists.oasis-open.org>
Thread-Topic: [virtio-comment] Re: [virtio-dev] [virtio 1.3] Feature freeze
 has started
Thread-Index: AQHZrau3eCaKRhNSn0Siy/I5kZqyW6/ETamAgAATsOA=
Date: Fri, 21 Jul 2023 14:21:05 +0000
Message-ID:
 <PH0PR12MB548175963F5D563547805173DC3FA@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <874jml2mmb.fsf@redhat.com> <87h6px8l94.fsf@redhat.com>
In-Reply-To: <87h6px8l94.fsf@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|CH3PR12MB9169:EE_
x-ms-office365-filtering-correlation-id: 1a52464f-246f-4d56-6ad0-08db89f5b87f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 zNj9xlCvZwMBGUUr+dC4IaqkPVFzFQkN7jz+oAOnTcjJfOVAcBvw7Pfv+VDEPmT+ZxiZzB+hKCeIe/8FZqWIkmdyNyVaMqMhh8spT4j1lqwvbOrZhkEFKZcLh+RtwPXnSpjrOBtmKjyazKO53vhplbLbocnMjPbHlPK3VgsDEOHT8hyVFkZuNrsp/OUGuxRhLwvZ6cOUE+oF7UAw179Vdgm7rWR2oCSO3leIPig2/Ldxu68vPWbfTxnkClrXHRvumoEruwRxsaR3OERVkpxNTUetLoZm1uVy6qBX/umIo/HxluPdetjp0IDubBbGWa0HyKjgg05NDZQRLUw4so3UiR3v9DmeYVubg7D7F8RF/+Wr2iKBx2Q8tp5tvNyRU14mAPMmYrqIOVQ7668QTq50Ln/wh/YiJYYyP8OdxfPzibgtJUt1NdMowEHnHw0L0nqJLknEp7WwsUNdTyOMeOMUE1iuguMLlj9hWpNVKLf3wnahPfoEBH1ba3N7uiZUBgJerYZfroTrhXMT5ITRYVrpHFlSiSTPzc05JV/pFzCjVXtNaYRqJa5Hii4aBYFvp/m7Iqjra87pYf/buydn/CbWs/3NanpWDVO0FlMd27J7CP3LmbhHAnS+W6XAhF69PaIWRBRFmowsdwqgsrViX+z0H5ki8rd22By4RG1xjwvAuic=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(346002)(39860400002)(136003)(376002)(396003)(451199021)(478600001)(186003)(6506007)(9686003)(966005)(55016003)(4326008)(8936002)(4744005)(33656002)(86362001)(41300700001)(7696005)(5660300002)(2906002)(316002)(8676002)(26005)(71200400001)(54906003)(122000001)(38100700002)(66556008)(66946007)(64756008)(110136005)(76116006)(38070700005)(52536014)(66446008)(66476007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?7AAZcqTZY2mm6ISQRTaC79Fz8hUMWZJkyCGC9v4aR339Sazagd2zZvIDhQwA?=
 =?us-ascii?Q?VXQkZbNJu6oKnFNM5zGwkf6Htj+rMvSTEzj7wckbSOzMDd4f7azZwJE5yZfz?=
 =?us-ascii?Q?dk/wTCNZNCC3kqI6oqsP0w9Nny8CpGF1YP1gcljG9jSULHJOSLDLKa7qid0a?=
 =?us-ascii?Q?3HlGrf27qqA6/i2y3wpv0i14U9LW4tvRcqF4W/cUEgouAPUSvN0yeiLPnIQ5?=
 =?us-ascii?Q?ZSsJMAJ103Anpi+4i4vzA72e9VDvOSn8kR8LHzES0NsjrIwBzkg1AeZWvGxd?=
 =?us-ascii?Q?l2Nz56vNmQwd98BwU3dSo6IKWKmJddllgLULrOVBpTlxe+2acTQ+/nKqugqM?=
 =?us-ascii?Q?ux4Fw6A4OJFUN7PkYgqM9rVuublijUB1p7rMLTrDEt87NtbxV43eCLG1aQAD?=
 =?us-ascii?Q?d92jHLA0LPct6VnZKTC6Za6A9MJZLrDwzkG+HmWJB2VmsQknSfjJYTLzj6hB?=
 =?us-ascii?Q?2IMBaFNpynMLcj/Qzw+cglm9R42qhNZCMevBp3ra69ByIblYktHKAIM5LGdx?=
 =?us-ascii?Q?mfCru/LEcDPuBr3YUJJUqCDe5BOLj/GoTwdlgUY++fZMW48kDU/65kCb2ttC?=
 =?us-ascii?Q?a7OMO5kt4/FHNH1937kCRoJpDKPkYuC4F/DzDZjuXmDYr/0h3evjWguoXBEd?=
 =?us-ascii?Q?DVGUHAIwC8XyH+cFj+lfkM3dyQWC0NhvzsRsXLdKb4ME6BXNchiFr6TvB/GY?=
 =?us-ascii?Q?2zco13yGYKy9zlOlucaUdsE24Ural2QYcl3eCLS1S/lIMvXijBZcLXcZ7V7I?=
 =?us-ascii?Q?VBFK7vJ9HcPnHDnZqdZR2PlfjXYBXSdcsqVf6v+DDhB8BBWvW+AX2W+lUskA?=
 =?us-ascii?Q?bCMnnMRpxDQT1bLdg/L1H8fveK426Tyo5a+FxT6rwr/h8mOceQVTLXBVWzaa?=
 =?us-ascii?Q?3Ol5+ka9vLRsNcNetEX3tKIM78xb6thKhu/3oZ9QAl6pT1a80EBrk/WCoL0Q?=
 =?us-ascii?Q?6+V5EcZ5hkEK3g7fmvqlg0w+mysKe+Sqa6OT/BrIZ3aeurxueOVGh2gwWuYo?=
 =?us-ascii?Q?y2Nyj+C9vtMYD2U54+z1QdF5/OKbOzD2BN95BDS2DT3uf4GqrINC8BCHPIY5?=
 =?us-ascii?Q?HdWfP1ukjtwIIp9YDnWYXW5tPlTE1Hw73L6gV5RWh5F1ep2hpOC68ik9yISe?=
 =?us-ascii?Q?Eux3iBJ9fG4Sulb7HjClnmIYI3sr3tc3tBUWQEmg77OpPvZcFQpbVYskciqd?=
 =?us-ascii?Q?tWGEZFHXdZHHknq/OyltFPdqRzi5Fo4NWzAUi/FNboCNx5eJ7/2s2+Uf2xSs?=
 =?us-ascii?Q?uI5HY5uHyzCQCbOP1V8JSgPnAhXk21QYIVoFqP7LQGesYOwxeitD9i6x1w3L?=
 =?us-ascii?Q?f1Geg04q71z+wO+LtVlN5Wb5bELiwSXFcwxWhDsQhASwGXU/5oj44YWYG4Sj?=
 =?us-ascii?Q?Htzu6LKjCdwQig8OEi9lRIQ1ebDS+iYxjkNZbRKnud3PtT8mFPHYS0pbAJjV?=
 =?us-ascii?Q?xQq5s/si8Ajy5jvG6voXFzmYloI1MjCGewpt9FR9k7KG1hNzWcFi2MumidxI?=
 =?us-ascii?Q?fBpy9h34UN9CyQMGu1Z2F58F66Go5HScprNTVDExBEJGmuz6TWaBz8oNkKiX?=
 =?us-ascii?Q?l57/JKdIUhM774TvA5s=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a52464f-246f-4d56-6ad0-08db89f5b87f
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jul 2023 14:21:05.8224
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5F1loa2ajBCP37uk08+S0ocW5O3v382iulDUKmDha1d8HZs5WUkIeMaazraJUMWxKrWx9pzot0AtOV7eQGoTgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9169
Subject: [virtio-dev] RE: [virtio-comment] Re: [virtio-dev] [virtio 1.3] Feature freeze has
 started



> From: virtio-comment@lists.oasis-open.org <virtio-comment@lists.oasis-
> open.org> On Behalf Of Cornelia Huck
> Sent: Friday, July 21, 2023 9:09 AM

> > https://github.com/oasis-tcs/virtio-spec/issues/170 ("The size of
> > virtio_net_hdr struct are wrong when VIRTIO_NET_HASH_REPORT feature is
> > negotiated.")
> >  * Can someone please check the status of this? Looks like a patch is
> >    available, but no progress for a long time? Is this maybe interactin=
g
> >    with the inner header hash feature?
> >
> > Any others that I have missed?
>=20
> Last call for 1.3. The first two are done now, the third one has not seen=
 any
> action, so if anything, it's going to be post-1.3.
>
=20
> I think we're good (and can start preparing for the next steps).
>
Yes, we can do post 1.3.
The fix needs more words than what was posted. I will post one when the bra=
nch opens.=20


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

