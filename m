Return-Path: <virtio-dev-return-12026-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A239FC76188
	for <virtio-dev@archiver.kernel.org>; Wed,  5 Apr 2023 14:06:12 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id E6C9223D5A
	for <virtio-dev@archiver.kernel.org>; Wed,  5 Apr 2023 14:06:11 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id E0B279865B5
	for <virtio-dev@archiver.kernel.org>; Wed,  5 Apr 2023 14:06:11 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id D4E1D9865A7; Wed,  5 Apr 2023 14:06:11 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id BF4BE9865A8;
	Wed,  5 Apr 2023 14:06:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mcp7vPB+KBhhhM66OYnYGEZojo4i0VmpbmIjAFxtU42d0uMRGfd/eSMV5aTTMew9l+CTq6JMuoTz0eF1It5hjXSDevhwSKtQO7w6cQD+I+t2hlPb8Nl3xNnWj4pQpsGMZtAhPuumalUqQQNdQXUv3aBcQ5L685pAlVN3k0TDwP7VwlAwQYQIEC/DY4neadWWkVctvIm3D0NOeQj1t5PrmbxNu6oRH+Ap+Xv8lc0OIhxI8Yse17OTNkIaMmju6vd9jKa43h/9bIcqnm+bZK5MGIDqHraf6kD625DmiTZPzKQPYUgqMvPVAGsy/MDbtgob5Z7o0Qyg3JqI0hl0bQy3pQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0No7H5mg7IhjvBx9QBcxf5S8Go71OxWxHRI3s62ZidQ=;
 b=DDM1X84Kxv/B0ugSBJeI3qmpOXEiuYmBytiuWsFmJmtlbNjP13hpktbgNqEZicmqdza7VFTrXX1N5+6pp7siSU0du7MVn5ifeW3aZWDMIys3bHZcuFSk5Of/uHQuRYABfEltSS6UXUWH71rGE33e5hommirfpk3LjzdOOoYrNAin2SKwNHwwOGX5+NrZrw4TEnE97qxEBoOAd74c6MNw7UOf6bPqkfRvkLAoX6oQtVwU/qBYX8wngLg+fckfxJBMdOlnOtx7PeHvjJ6W2O/8zWg7wb2RXKk/Om6OBfivGD3q0iXzBjlpqkJYZUp4ODa7rvVIB50Aiker7uUwuCYVUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: Cornelia Huck <cohuck@redhat.com>, "virtio@lists.oasis-open.org"
	<virtio@lists.oasis-open.org>
CC: "virtio-comment@lists.oasis-open.org"
	<virtio-comment@lists.oasis-open.org>, "virtio-dev@lists.oasis-open.org"
	<virtio-dev@lists.oasis-open.org>
Thread-Topic: [virtio-comment] [RFC] virtio 1.3 schedule
Thread-Index: AQHZZ8aHU5CRv9oJlUO6NOK3Jx19Mq8cvfDg
Date: Wed, 5 Apr 2023 14:05:59 +0000
Message-ID:
 <PH0PR12MB54818CAC4966B180BAB8808ADC909@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <87edoyqvnu.fsf@redhat.com>
In-Reply-To: <87edoyqvnu.fsf@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|CY8PR12MB7292:EE_
x-ms-office365-filtering-correlation-id: a5ad4f87-9e48-4098-613f-08db35dee24b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 aAzv6iho90GUDkQ7BUfD4XOXJb20ESRLyJR8Py7aN9uHxPlqT71HdAq/RKd4RoZLZGsrvSdoMVG8nray8ntnn7z4UpThKnr15kFaTC6LjaqdWp98+z6RgMCvyQvUb+9eJZZH9UvpoNB/9a8zfnkakwwgnuSv4khDFVxvjcwsUSYHF3DAHASeMcoUGW44JFcEMP+wHwviNaQxVbPOCHHb11BNS+SEPJkJ2hXGvqK5pjln0RxXR12eFAFjsWEVlgZ8mc0tOx+N3eKGdS23rXpZjRvMvJMJtDbcEaOAjLvmMqJQojxT43HVvPiBmtBldXCbs9RiHKcTJZwLTrSp/XutUiuMMyhHliYbuF/aVekMMx4g4cnftjvek3v+4yTXAZdn/buG3/KafOqnGh+Ks327A4X8SzoLrYYFWoJOToLfNwZscrJRp8WGkuvzyEOY0jAan8e0qjQLxSLZ7RFWliYnzvhwPCQMt7o539tKggTKQESiIwyCcWPoxth7VtFjonOrMjsfyIlntOLsDDROyTnR8nagsRTR7U+q5RYtGAXDeWzyK5eLdEAmiImbbRS9WNGo7wVc2Kj3BV0iQWLW3VVKODGmzH/DcHsc8YJcFP3BNnyHTEtRRvGVAOU9iTWdakqdQQpGO7x2l1mWKzup/CmsSMnL4W9SQwb254JtxfGIAwU=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(366004)(136003)(376002)(396003)(39860400002)(451199021)(38070700005)(966005)(83380400001)(122000001)(55016003)(9686003)(6506007)(38100700002)(186003)(8936002)(52536014)(2906002)(33656002)(5660300002)(7696005)(478600001)(41300700001)(76116006)(64756008)(66476007)(66946007)(66556008)(54906003)(71200400001)(8676002)(66446008)(110136005)(4326008)(86362001)(316002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?2jre9mX09zAl5UOc+WPuano/pA3dwGl+Je9aldTDbgt75tLgcyOvsvaL17GK?=
 =?us-ascii?Q?ioacMbsElTl8910yZrn0F23IeQ8LpKRJHwnTrPzB3hr0EdlwMotUnIN7YWss?=
 =?us-ascii?Q?cNgIWNTUtqJNc1nkSVdKMJLh4Vs3BQwLqGmczl+8TQARXCztDPb2dBOpfXmi?=
 =?us-ascii?Q?JjPDDebBau7ViikDTIslVAWu1BpKRD+7BEBQNOCE9HSlQGPjaW1NcVf777ps?=
 =?us-ascii?Q?DWC0k+tIadGkj3UVtkGyJHOdihEcpvmio2y/ggNMT70y5MB9kr4WECPL88Mv?=
 =?us-ascii?Q?o3Xsm4NzxLKq5lZLlxo90m4JVXblnPiCpDopk66tw/+2cgXXnbFFyOiMKkU5?=
 =?us-ascii?Q?v2d8gLaDAQnwLGS4Ft9cqrFsPCx3ZiBMU6+cJ4uSn10FxS8ACzknyd8cKaRm?=
 =?us-ascii?Q?uIpX5Hk8bHEpShC4GOnnaVRCsqPG8yLw40qR8EekWYXSLSu0QZUjY+RH/wIc?=
 =?us-ascii?Q?vqrX7Baob/je3Qpg+c6yjF0hmpB+OVnetOvGCbzGAnXN9zzjD2EK714nt+zk?=
 =?us-ascii?Q?/HLb6AJJf72JPWExv002cpiSn2UMD5jJwK+s/M7RQw+vdLDkD8zZ2lKtCZt6?=
 =?us-ascii?Q?S++KXg6ZSxmoMnwPAqO/ZOtla0gGF6YFAPgXxN/IyVKwAjrNm23D+P1Z3sgX?=
 =?us-ascii?Q?TAF+MJO+XsbWTykFlm/syyuAVcqRy2LoKzzVHXNlilbZVlpMS30FTX5cDx6m?=
 =?us-ascii?Q?qHNTcrgJaluIM/aeZnnELtZCaxxmKVAMXOD/qKx7rKnq3MW7kKBEpndMpPqG?=
 =?us-ascii?Q?50NCYZ9RlbzPClUDWBLabw0FKZlvAqC5V+x24IZLqpHXhH6VnMnWMyuFYxyP?=
 =?us-ascii?Q?e49f8HcthqS4392pQeQEINVM6FrrdGzZDzf+uwa9JdsIWbAKjWZpVaDYazfO?=
 =?us-ascii?Q?DHDeBNIAFak91DoqSifX4zUzdTBEaZW8167fG+Y2/oDqJP1hCG4Jc00wWB19?=
 =?us-ascii?Q?F3rXxaMn9yRMAsBTIcz/DOh97ps/eKantJuMOoVZbuiGVuAoK7gIVxoy1A4X?=
 =?us-ascii?Q?whXbZsD3WrYK5S/Y16erAVKZ/dh0DfzHcPEKDjySx1J8USjXSRgnijPBTZzq?=
 =?us-ascii?Q?2a3i7ViDR3q50FYX+zD/WEn9UzYjZ+ye1jUVFWUc4qpFC3EvNpcwERNgEsdF?=
 =?us-ascii?Q?2fI32dq4X/0bKaHqz2hrVTfOGZ7rDN0Vh2kio8P1X030PFt4v6JG0yyjFiwy?=
 =?us-ascii?Q?DrY6JkySZhl701MpVEuE33bOq0NZ41ZnJaPV/oev0eAa2J99ZTejPw9EAR3p?=
 =?us-ascii?Q?rYPwIeY1qQ53gg29W+GIS3Rw6xKl13bC47ymvDGIesOU4GSofiMvsHyT4xFt?=
 =?us-ascii?Q?fbA/1eZ5Y49EXNjEdMXqSfgwL4RZo3U2Rv0o6sRgiBxKgHuHUnG/XkY/MNXF?=
 =?us-ascii?Q?w83xz+hg8+2sQsU0brBYXIoCBNlUk56rOBMchMFue2impeNNAup5MrorVoQ0?=
 =?us-ascii?Q?NWyZf4aQ0xABBL5HLEI6CcHxu0DOSFkd8UNljZeU5LDtKZHFb7HVzpnTPBR6?=
 =?us-ascii?Q?HEzMkxaZQDgbemjPKQHHiXEs8y9ZkbRihjG1XvKPRcqzHEFI6a49NSm9NSSt?=
 =?us-ascii?Q?aRahIFgU3pR4VSnWEDKurqgkjwaxR08I4+QGAZ37BQMuKtNH/9ZoUv9N8MQl?=
 =?us-ascii?Q?RyYLFlapVVmvRUxAaHRZ35Q=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5ad4f87-9e48-4098-613f-08db35dee24b
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Apr 2023 14:05:59.8527
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +RKmNuP6MfA5O3VkhVNWj2yMDcloqYe9tTNDPtyfpao+D6qzJSUsXVm72JQcGQ8gcIIeLMDfjes39DEK7osbaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7292
Subject: [virtio-dev] RE: [virtio-comment] [RFC] virtio 1.3 schedule

Hi Cornelia,

> From: virtio-comment@lists.oasis-open.org <virtio-comment@lists.oasis-
> open.org> On Behalf Of Cornelia Huck
> Sent: Wednesday, April 5, 2023 9:57 AM
>=20
> The virtio 1.2 spec has been released on July 1st, 2022, so I think we sh=
ould
> come up with a plan for the 1.3 release. Given that it took us several mo=
nths
> last time, we need to think about declaring freeze during (northern
> hemisphere) summer if we want to have a release ready before the end-of-
> year holiday season starts.
>=20
> We have some things currently under discussion/review that we should stil=
l
> consider for 1.3:
>=20
> - vq index etc. naming cleanup
> - admin vq
> - virtio-video
> - some things we deferred for 1.2 (see
>   https://github.com/oasis-tcs/virtio-
> spec/issues?q=3Dis%3Aissue+is%3Aopen+label%3Adeferred-in-v1.2-csprd01)
> - other things that are not on my personal list (please mention whatever
>   you think is important)
>
Please included transitional VF device support to the list whose proposal i=
s already in progress.
It has matching github issue.

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

