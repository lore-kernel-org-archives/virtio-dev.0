Return-Path: <virtio-dev-return-12278-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C942C77B75
	for <virtio-dev@archiver.kernel.org>; Tue, 18 Apr 2023 12:06:20 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 7EBEC1CA248
	for <virtio-dev@archiver.kernel.org>; Tue, 18 Apr 2023 12:06:19 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 783DD986435
	for <virtio-dev@archiver.kernel.org>; Tue, 18 Apr 2023 12:06:19 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 6EABC9863E7; Tue, 18 Apr 2023 12:06:19 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 5A7C49863E3;
	Tue, 18 Apr 2023 12:06:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nMtGLqfwcJXjNItwT55AK9jRhlXY8ah6Vr8tR3R11rRa1KPEQj3tkTuCbQE2Fgwh4nZEb6We3r+VSx2FpdNzN1IMe5hyTWrFRXO/wE2/bpjbrPJf4f2Rn4s6VwG3kE0QcdCjs1NRGbHaB4CPJKiwl/uK6k+khezL57gFR5Rb5jSzznzRHmdtr6T8Lyp4CpCQXX53Qc+uRxCYW+UtvmS+znO4IM0rFrEx31JH0B9On7BLqnun9b/ZeCVMuRdN5X5KcRB06gKw3LzTeYJvRoUOKzQNGPHX01IE1ZWCFYUSLQB9XY0g9M+VG1N9+TESLgS4eAewtnjpjylydYssDlRM5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tvzsi008MqAKYban1LCe3lI7tk0HZJjXYe9GjULnpGY=;
 b=YSNq0gJ9bxlxxBNbSEaZ+TgKP8myJdCbo/x/j4CBWwLRDOEN79+pxWHACwz/tLru+nW+O+7hQMy1S0t65xBflTyyBGoAI7IoFzGoBnYtXywYZEoK2u5A32tTArc0LEj38nKwKpOMiU/HToSJFvvFWS1dH42u1Jhebp0jh3ZifgvjYjAJxk7Bj4He90tOTUvFbKdVpc6/hAupGxF/OQfl6Yi2oPN2ZIa7ErqKA6h7WRmIgBZZgwuKz34A2tIPgk/dyoS6QIHsFfBtExebSqgpn+YCUhRuDqI8Cp1+oc8C2DudAc9mP/CH+v9gskxExx/icc4JiMRvmXxOU2aE/5w2OQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: Halil Pasic <pasic@linux.ibm.com>
CC: "mst@redhat.com" <mst@redhat.com>, "virtio-dev@lists.oasis-open.org"
	<virtio-dev@lists.oasis-open.org>, "cohuck@redhat.com" <cohuck@redhat.com>,
	"sgarzare@redhat.com" <sgarzare@redhat.com>,
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
	Shahaf Shuler <shahafs@nvidia.com>
Thread-Topic: [virtio-dev] [PATCH v13 03/11] content: Rename confusing
 queue_notify_data and vqn names
Thread-Index: AQHZbKsw5xtQpz9Phke1SvpgoB/q7K8u476AgAEd6fCAAPoEAIAABw9g
Date: Tue, 18 Apr 2023 12:06:12 +0000
Message-ID:
 <PH0PR12MB5481881DEA4B7B7E182510E0DC9D9@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230411192341.751841-1-parav@nvidia.com>
	<20230411192341.751841-4-parav@nvidia.com>
	<20230417054149.5d7f62e8.pasic@linux.ibm.com>
	<PH0PR12MB548148EDDB407D4B1A3E316ADC9C9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230418133958.13d5b98b.pasic@linux.ibm.com>
In-Reply-To: <20230418133958.13d5b98b.pasic@linux.ibm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|PH8PR12MB6771:EE_
x-ms-office365-filtering-correlation-id: 8c3b1409-102d-40b3-2469-08db40054de9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 CNEBHHl9Fukmjqm80TgHvumg2zxSuXHhiHuSWu2IZlEHjqjmy+ef+atzXvYUUz2BaNpSEPrD5cesYKE0qPIVS46yjDxlG6+LSW8h+p3jJcLKDDj+Qf5nV9iHm1V6FhWl9F6InHUD2LlyH9TtULNFgYNYIzMdumEUtf0KKhp7m/Njn5PrCua19bcXvklwcYR59R2J7HRRX31YYaFi+jiFLIdw8QkuONNdHradka69zBW75kuqjCSwwzOE+2wSOlv06mQTt0E/ygc7TshiBDodUwZxYcrVG9cHdSlB9pHFHlix/iz6NoLk+0oVGTUT1BBb4asycV6oO/zWh40+GZ2JGTZ3wRQwoE6kOfLoiNqigLR6nM1ojcokipLfpq0w532zLdeZUQ0FZ06v/ayPMm4Z+yTVz3YiD2phWOo3xsiETef8eGxgL81Qd9/fozoIZkpQMpYICWIvOm0W38MossEgeYAO3P5iazHLfNRWlrJ0j69IJ4E/p674+owNEXZ+jMnxp3C1pN/aQ7w3618JZCvTbi4+EbnkWSze00/pNwsSDBGY/EbeqxJ/BZrx4PraQTeXN7ng6EzPTocRWSYKKnEbspeYWYCFQVlDFHyCQniepaU/0GMHGi1XPUQaGx3yqDHF
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(366004)(136003)(376002)(346002)(451199021)(478600001)(71200400001)(38100700002)(8936002)(8676002)(316002)(41300700001)(6916009)(4326008)(55016003)(76116006)(66446008)(66556008)(66946007)(54906003)(122000001)(66476007)(186003)(107886003)(4744005)(2906002)(38070700005)(26005)(64756008)(9686003)(6506007)(86362001)(83380400001)(33656002)(5660300002)(52536014)(7696005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?fnw6eEDXB8xHK86OV4aWq3r6hmR3W4qQSuIKU00pcQu5rlszJLIrwk2eHkaA?=
 =?us-ascii?Q?qCwnbgyMZk8BH/4k9ZPHUQ1xaaOAyT8Ffz05uWr8VlmQNO2CSqPrgtJo/FxI?=
 =?us-ascii?Q?uIj1Y+saB4MJf9D7kRh2bmW3SSIDZP4vIgJdA6G+Mw31ti9FDktBxjmvj4pm?=
 =?us-ascii?Q?TtbGPzrYJzBojdZjWWqZkEeVlJWdlfvDfkkvXbG//ulP+ASBax7+sjGVq1ND?=
 =?us-ascii?Q?aT8F/NYvNVvRCxhv9vRVQGQG+fZPtv/+EstJkX0SEQ7RM73e5hwxevpxYExH?=
 =?us-ascii?Q?EgoB4fP0WroKO47HHNTeIg/49xvtrJzgFKocgf40/aUpNpFOD6KLiAofkUhg?=
 =?us-ascii?Q?hDMK8pUxLd0UjuALxl+gkoqGsvH82khPn2ygb33jjY6hI81IXADU62lCzFpY?=
 =?us-ascii?Q?RiGEqCdMM78M2/sYTl9v9PDsGRtwDs7sI5HVUCZwtg+zHGA4ElYe0fgo0M5M?=
 =?us-ascii?Q?2s1wpiCuJUaFhZun+bdmv7JU30iQ7lCj7i3AsFhj5u9zyNxps2t1pS/PE2tN?=
 =?us-ascii?Q?LqquNiFT1eIIHbsUYcMEvaFCQrt/vB4tLBSB2BdeqjJiW1mw/cSCCZHG7rcn?=
 =?us-ascii?Q?Hh9lRvxZtshyOo0Kl5jnWD2A3n92r2X2NrdwwIf9PM/5Eqo7uBmTDFykkndB?=
 =?us-ascii?Q?V9TkB7MGZp15M/d/AMG/DHfX4wHH5sEN2pLfL9g92SztkDFUp/sMBQtRHH9V?=
 =?us-ascii?Q?TYqxudKi3r3IpjcotfOXRvjybr8KHyPL1xZIzYj80iUM/Q7XTmQUFWq5nu3W?=
 =?us-ascii?Q?qhc878dXG+y4yY/4Wy2hOco6PKDpsHpYTm+OsoQsdz+3FH87DDnDDbMpNQfz?=
 =?us-ascii?Q?8OSmC7/bGYV1fpbEq9574KF7oYHg3gHcKzU6r79BL+ZX96+OgSIdRQyFO5Xs?=
 =?us-ascii?Q?J3SU3wXU5cOakdZd0h/M3BaWaz2RRsuyAdNOR0/eYQ3JjtZtjayVwnXysc4a?=
 =?us-ascii?Q?Etga864t0Q2vgT5HXmJXr2BmAQ+rXmhEv9XWaZ+cD/imvATgs0ieUl1ENVRH?=
 =?us-ascii?Q?TbEVrwCwB+xhyyjACWSR5MOZbU2T2eyQbHzR4f8b33Za3zkEXRp2V2WE/7Xd?=
 =?us-ascii?Q?CRuy/u+9EjYVGgVrBbBGtjsi8mDK6mpik9db42N44t3oghFEsdZuRScCDItD?=
 =?us-ascii?Q?UePwDEh5N0oSCgpvL2lWq/nW/ZJtfAtgppeYYU0Le9kTQV5WRec752Do1Kzo?=
 =?us-ascii?Q?Hm8Vi0vkYGdKTAzFT7cxjjodel73WnQVjeDhG0MAk2ZuW9GcLQOfs/tnZlJj?=
 =?us-ascii?Q?lq3CGG8J4C+m8I6HaA+IQ1egsEmWYSiNbTPLhXkfp8m5rWxDCLonukawwtzq?=
 =?us-ascii?Q?7fxMRAtvxOiSqcjBDP1SGBNWKm1Mca7TcOVqqilSeGZ9KLk+kBVtve3obXpW?=
 =?us-ascii?Q?O/+gJufx609nSkjkFhJP+DRxuIpdJXPx8tttSrQM8VQYjhxGn8GP6Vhlxmv3?=
 =?us-ascii?Q?XVchvz/Ei23/C1BTjg9CADZUy6NXxvamBtAAhvigvU5XXdGBrbFj+Dg5NbZG?=
 =?us-ascii?Q?tsWCzgqyATesWs+AAIvTQLtydkLShMKP0AQzyY9wKH5PzlSH63XXNmgLCIft?=
 =?us-ascii?Q?WNA66kDGBbW2uxpwhr4=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c3b1409-102d-40b3-2469-08db40054de9
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Apr 2023 12:06:12.8749
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 03bdYUtRXdBW1MgzrHUovtFUgH/eAFl30q0qEO2bXl+PbZoOdl7Iy1b3jMNEXQvvDY2ipzTK2JsgMiggyOibkg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6771
Subject: RE: [virtio-dev] [PATCH v13 03/11] content: Rename confusing
 queue_notify_data and vqn names


> From: Halil Pasic <pasic@linux.ibm.com>
> Sent: Tuesday, April 18, 2023 7:40 AM
>=20
> IMHO VIRTIO_F_NOTIFY_CONFIG_DATA should remain aligned with
> VIRTIO_F_NOTIFICATION_DATA in one way or another. Thus way out would be
> to do something like:
> virtio_pci_common_cfg.queue_notify_data -> queue_notif_config_data
>=20
> I think as editors Connie and Michael should have the most say in this th=
ough.

Are you ok with above name?

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

